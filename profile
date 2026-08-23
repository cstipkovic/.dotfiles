[ -f "$HOME/.dotfiles/common.sh" ] && source "$HOME/.dotfiles/common.sh"

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

[[ -s "/Users/cstipkovic/.gvm/scripts/gvm" ]] && source "/Users/cstipkovic/.gvm/scripts/gvm"

# mysql-client
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/cstipkovic/.lmstudio/bin"
# End of LM Studio CLI section

