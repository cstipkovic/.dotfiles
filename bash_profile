[ -f "$HOME/.dotfiles/common.sh" ] && source "$HOME/.dotfiles/common.sh"

# ######################################## Ruby ########################################
if [[ -s $HOME/.rvm/scripts/rvm ]]; then
  source $HOME/.rvm/scripts/rvm;
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# ######################################## NVM ########################################
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# ######################################## Java ########################################
export JAVA_HOME=`/usr/libexec/java_home -v 11`

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# ######################################## Go Lang ########################################
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

# mysql client
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# Docker (Docker Desktop)
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/cstipkovic/.lmstudio/bin"
# End of LM Studio CLI section


test -e ~/.iterm2_shell_integration.bash && source ~/.iterm2_shell_integration.bash || true

# GitHub token for Claude Code MCP
if command -v gh >/dev/null 2>&1; then
  _gh_token="$(gh auth token 2>/dev/null)"
  if [ -n "$_gh_token" ]; then
    export GITHUB_PERSONAL_ACCESS_TOKEN="$_gh_token"
  fi
  unset _gh_token
fi
export PATH="$HOME/.local/bin:$PATH"

# work-brain
work-brain() {
  local subcmd="${1:-}"
  if [[ "$subcmd" == "session" ]]; then
    shift
    bash /Users/cstipkovic/Dropbox/Obsidian/cstipkovic/Companies/session.sh "$@"
  else
    echo "Usage: work-brain session <start|end|summary|log|moc> <Empresa> <Projeto> [args]"
  fi
}

# Added by Antigravity
export PATH="/Users/cstipkovic/.antigravity/antigravity/bin:$PATH"

# Added by Antigravity IDE
export PATH="/Users/cstipkovic/.antigravity-ide/antigravity-ide/bin:$PATH"
[ -f ~/.bashrc ] && source ~/.bashrc

# Descubra o caminho exato do binário rodando 'which claude' ou use o padrão do Node/npm
CLAUDE_BIN=$(which claude)

# Cria os aliases apontando para diretórios de configuração isolados
alias claude-m="CLAUDE_CONFIG_DIR=\"$HOME/.claude-majmun\" $CLAUDE_BIN"
alias claude-i="CLAUDE_CONFIG_DIR=\"$HOME/.claude-intelifi\" $CLAUDE_BIN"

# Proteção opcional para evitar abrir sem contexto
alias claude="echo 'Use claude-m (Max Majmun) ou claude-i (Pro InteliFi)'"

export PATH="/Users/cstipkovic/.local/bin:$PATH"
