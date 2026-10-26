#!/usr/bin/env bash
# Bootstrap de uma máquina nova (macOS).
#
# Uso:
#   curl -fsSL https://raw.githubusercontent.com/cstipkovic/.dotfiles/master/install_my_env.sh | bash
#
# Também pode ser rodado localmente:
#   bash ~/.dotfiles/install_my_env.sh
#
# O script é idempotente: pode rodar de novo sem duplicar nada.

set -euo pipefail

GIST_RAW="https://gist.github.com/cstipkovic/9118447/raw"
DOTFILES_REPO="https://github.com/cstipkovic/.dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

# Xcode Command Line Tools
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  echo "Conclua a instalação do Command Line Tools e rode o script novamente."
  exit 0
fi

# Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Apple Silicon: brew fica em /opt/homebrew; Intel: /usr/local
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Brewfile: usa um Brewfile ao lado do script (se existir e o script não for
# lido via stdin), senão baixa o do gist. Não usa o diretório atual para não
# pegar um Brewfile errado quando o script roda via `curl | bash`.
BREWFILE=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "$(dirname "${BASH_SOURCE[0]}")/Brewfile" ]; then
  BREWFILE="$(dirname "${BASH_SOURCE[0]}")/Brewfile"
fi
if [ -z "$BREWFILE" ]; then
  BREWFILE="$(mktemp)"
  trap 'rm -f "$BREWFILE"' EXIT
  curl -fsSL "$GIST_RAW/Brewfile" -o "$BREWFILE"
fi

brew update || echo "AVISO: brew update falhou; seguindo com o que já está local."
# Não aborta se algo falhar (ex.: sem login na App Store); rode `brew bundle` de novo depois
brew bundle --file="$BREWFILE" || echo "AVISO: brew bundle terminou com erros; veja acima e rode de novo depois."

# Ferramentas novas que podem faltar em Brewfiles antigos.
for pkg in tmux yarn; do
  command -v "$pkg" >/dev/null 2>&1 || brew install "$pkg"
done

# Dotfiles (shell config incl. claude-m / claude-i). Public repo, so HTTPS needs no SSH key yet.
if [ ! -d "$DOTFILES_DIR/.git" ]; then
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  git -C "$DOTFILES_DIR" pull --ff-only || echo "AVISO: não consegui atualizar $DOTFILES_DIR; seguindo com a versão local."
fi

bash "$DOTFILES_DIR/install.sh"

# Plugins do Vim (o install.sh já baixou o vim-plug). Roda em modo batch para
# não travar quando o script é executado via `curl | bash`.
if [ -f "$HOME/.vim/autoload/plug.vim" ] && [ -f "$HOME/.vimrc" ]; then
  echo "==> Instalando plugins do Vim"
  vim -Nu "$HOME/.vimrc" -es -c 'PlugInstall --sync' -c 'qa!' </dev/null \
    || echo "AVISO: PlugInstall terminou com erro; abra o vim e rode :PlugInstall"
fi

# macOS abre zsh por padrão; estes dotfiles são de bash.
if [ -e /dev/tty ] && [ "$(dscl . -read "/Users/$(id -un)" UserShell 2>/dev/null | awk '{print $2}')" != "/bin/bash" ]; then
  echo "==> Alterando o shell de login para /bin/bash (vai pedir sua senha)"
  chsh -s /bin/bash </dev/tty \
    || echo "AVISO: não consegui alterar o shell; rode depois: chsh -s /bin/bash"
fi

echo
cat <<'MSG'
Pronto. Abra um novo terminal (deve iniciar em bash, com starship/zoxide/fzf).
Pendente à mão:
  1. Entrar no Bitwarden (app) e na App Store
  2. gh auth login          (token do GitHub vem daí)
  3. git config --global user.name "..." ; git config --global user.email "..."
  4. ssh-keygen -t ed25519  e cadastrar a chave no GitHub (e no CodeCommit, se usar)
  5. Criar ~/.dotfiles/secrets.env com GEMINI_API_KEY (pegar no Bitwarden)
  6. Entrar nas contas dos apps (Dropbox, Slack, Claude Code: claude-m / claude-i)
MSG
