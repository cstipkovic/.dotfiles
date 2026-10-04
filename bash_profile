# ######################################## Homebrew ########################################
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# common.sh needs Homebrew's bin on PATH (starship/fzf/zoxide/direnv live there),
# so it must be sourced after brew shellenv, not before.
[ -f "$HOME/.dotfiles/common.sh" ] && source "$HOME/.dotfiles/common.sh"

# ######################################## NVM ########################################
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# ######################################## Java ########################################
export JAVA_HOME=$(/usr/libexec/java_home -v 11)

# ######################################## Go Lang ########################################
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# ######################################## MySQL ########################################
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# ######################################## Docker ########################################
# Docker Desktop CLI plugins + credential helpers
export PATH="$PATH:$HOME/.docker/bin"
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

# ######################################## Antigravity ########################################
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.antigravity-ide/antigravity-ide/bin:$PATH"

test -e ~/.iterm2_shell_integration.bash && source ~/.iterm2_shell_integration.bash || true

# .bashrc covers LM Studio CLI and ~/.local/bin, among other PATH entries
[ -f ~/.bashrc ] && source ~/.bashrc

# ######################################## GitHub token for Claude Code MCP ########################################
if command -v gh >/dev/null 2>&1; then
  _gh_token="$(gh auth token 2>/dev/null)"
  if [ -n "$_gh_token" ]; then
    export GITHUB_PERSONAL_ACCESS_TOKEN="$_gh_token"
  fi
  unset _gh_token
fi

# ######################################## Claude Code (multi-account) ########################################
# Descubra o caminho exato do binário rodando 'command -v claude' ou use o padrão do Node/npm
CLAUDE_BIN=$(command -v claude)

# Cria os aliases apontando para diretórios de configuração isolados
claude-m() { CLAUDE_CONFIG_DIR="$HOME/.claude-majmun" "$CLAUDE_BIN" "$@"; }
claude-i() { CLAUDE_CONFIG_DIR="$HOME/.claude-intelifi" "$CLAUDE_BIN" "$@"; }

# Proteção opcional para evitar abrir sem contexto
alias claude="echo 'Use claude-m (Max Majmun) ou claude-i (Pro InteliFi)'"

# ######################################## SDKMAN ########################################
# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
