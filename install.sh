#!/usr/bin/env bash

# The dotfile initial

os_name=$(uname -s)

# Linux
_linux_os() {
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

	_backupExistingFile ~/.bashrc

	ln -s ~/.dotfiles/bashrc ~/.bashrc
	ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
	ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
	ln -s ~/.dotfiles/.git-completion.bash ~/.git-completion.bash
	ln -s ~/.dotfiles/welcome-terminal.txt ~/.welcome-terminal.txt
}

# Mac OS Darwin
_darwin_os() {
    _clearExistingFiles

    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

	ln -s ~/.dotfiles/bashrc ~/.bashrc
	ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
	ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
	ln -s ~/.dotfiles/bash_profile ~/.bash_profile
    ln -s ~/.dotfiles/profile ~/.profile
	ln -s ~/.dotfiles/welcome-terminal.txt ~/.welcome-terminal.txt
}

_vim_plugins() {
    echo "Getting Vim-Plug"

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

# Common functions

# Moves an existing file/symlink aside to <file>.bak-<timestamp> instead of deleting it.
_backupExistingFile() {
    local target="$1"
    if [ -e "$target" ] || [ -L "$target" ]; then
        mv "$target" "${target}.bak-$(date +%Y%m%d%H%M%S)"
    fi
}

_clearExistingFiles() {
    _backupExistingFile ~/.bashrc
    _backupExistingFile ~/.vimrc
    _backupExistingFile ~/.tmux.conf
    _backupExistingFile ~/.bash_profile
    _backupExistingFile ~/.git-completion.bash
    _backupExistingFile ~/.welcome-terminal.txt
}

_dotfile() {
	echo "dotfiles"
}

if [ $os_name = "Darwin" ]
then
    echo "Configurations for Mac OS"
    _clearExistingFiles
	_darwin_os
else
    echo "Configurations for Linux/Unix"
	_linux_os
fi
