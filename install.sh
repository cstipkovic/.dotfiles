#!/usr/bin/env bash

# Symlinks the dotfiles into $HOME. Safe to run more than once: links that are
# already correct are left alone, anything else is moved to <file>.bak-<timestamp>.

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
os_name=$(uname -s)

# Moves an existing file/symlink aside to <file>.bak-<timestamp> instead of deleting it.
_backupExistingFile() {
    local target="$1"
    if [ -e "$target" ] || [ -L "$target" ]; then
        mv "$target" "${target}.bak-$(date +%Y%m%d%H%M%S)"
    fi
}

# _link <source in repo> <destination>
_link() {
    local src="$1" dest="$2"
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        return 0
    fi
    mkdir -p "$(dirname "$dest")"
    _backupExistingFile "$dest"
    ln -s "$src" "$dest"
}

_gitCompletion() {
    [ -f ~/.git-completion.bash ] && return 0
    curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
        -o ~/.git-completion.bash
}

_vim_plugins() {
    if [ -f ~/.vim/autoload/plug.vim ]; then
        return 0
    fi

    echo "Getting Vim-Plug"

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

_common_links() {
    _link "$DOTFILES/common.sh" ~/.common.sh
    _link "$DOTFILES/bashrc" ~/.bashrc
    _link "$DOTFILES/vim/vimrc" ~/.vimrc
    _link "$DOTFILES/tmux/tmux.conf" ~/.tmux.conf
    _link "$DOTFILES/welcome-terminal.txt" ~/.welcome-terminal.txt
    _link "$DOTFILES/starship/starship.toml" ~/.config/starship.toml
}

# Optional tools are never installed automatically; just report what's missing.
_checkDependencies() {
    local missing=() cmd
    for cmd in starship fzf zoxide direnv tmux; do
        command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
    done

    if [ ${#missing[@]} -gt 0 ]; then
        echo
        echo "Optional tools not installed: ${missing[*]}"
        echo "Install them with: brew install ${missing[*]}"
        echo "(or use your distro's package manager on Linux)"
    fi
}

if [ "$os_name" = "Darwin" ]; then
    echo "Configurations for Mac OS"
    _gitCompletion
    _common_links
    _vim_plugins
    _link "$DOTFILES/bash_profile" ~/.bash_profile
    _link "$DOTFILES/profile" ~/.profile
else
    echo "Configurations for Linux/Unix"
    _gitCompletion
    _common_links
    _vim_plugins
fi

_checkDependencies
