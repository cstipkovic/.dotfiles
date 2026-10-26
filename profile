# Set PATH, MANPATH, etc., for Homebrew (Apple Silicon and Intel prefixes).
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# common.sh needs Homebrew's bin on PATH (starship/fzf/zoxide/direnv live there),
# so it must be sourced after brew shellenv, not before.
[ -f "$HOME/.common.sh" ] && source "$HOME/.common.sh"

[ -s "$HOME/.gvm/scripts/gvm" ] && source "$HOME/.gvm/scripts/gvm"

# mysql-client
export PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/mysql-client/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section

