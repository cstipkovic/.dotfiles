# Shared bash configuration. Sourced from ~/.bash_profile, ~/.bashrc and
# ~/.profile (all symlinked from this repo by install.sh).
#
# Guard against loading twice (a login shell sources .bash_profile, which
# sources .bashrc) and against being executed instead of sourced.
if [ -n "${_DOTFILES_COMMON_LOADED:-}" ]; then
    return 0 2>/dev/null || exit 0
fi
_DOTFILES_COMMON_LOADED=1

export BASH_SILENCE_DEPRECATION_WARNING=1

alias ls='ls -G --color=auto'
alias rm='rm -i'
alias ll='ls -alhF --color=auto'
alias tree='tree -C'

# Run on terminal starts
[ -f "$HOME/.welcome-terminal.txt" ] && cat "$HOME/.welcome-terminal.txt"

# Git completion for bash
if [ -f "$HOME/.git-completion.bash" ]; then
  . "$HOME/.git-completion.bash"
fi

# Prompt (starship — replaces the old hand-rolled branch_color/parse_git_branch/PS1)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

# zoxide — smarter `cd` (adds `z`/`zi`, also remaps `cd` when initialized this way)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

# fzf — fuzzy finder (Ctrl+R history, Ctrl+T files, Alt+C cd)
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --bash)"
fi

# direnv — per-directory environment variables
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# Local secrets (API keys, tokens) — lives next to this repo, not committed.
# Resolve the real directory even when this file is reached through the
# ~/.common.sh symlink created by install.sh.
_dotfiles_source="${BASH_SOURCE[0]}"
if [ -L "$_dotfiles_source" ]; then
  _dotfiles_source="$(readlink "$_dotfiles_source")"
fi
_dotfiles_dir="$(cd "$(dirname "$_dotfiles_source")" && pwd -P)"

if [ -f "$_dotfiles_dir/secrets.env" ]; then
  . "$_dotfiles_dir/secrets.env"
elif [ -f "$HOME/.dotfiles/secrets.env" ]; then
  . "$HOME/.dotfiles/secrets.env"
fi

unset _dotfiles_source _dotfiles_dir
