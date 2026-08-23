export BASH_SILENCE_DEPRECATION_WARNING=1

alias ls='ls -G --color=auto'
alias rm='rm -i'
alias ll='ls -alhF --color=auto'
alias tree='tree -C'

# Run on terminal starts
cat ~/.welcome-terminal.txt

# Git completion for bash
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
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

# Local secrets (API keys, tokens) — see secrets.env, not committed
[ -f "$HOME/.dotfiles/secrets.env" ] && source "$HOME/.dotfiles/secrets.env"
