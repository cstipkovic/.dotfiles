#!/usr/bin/env bash

# The dotfile initial

os_name=$(uname -s)

# Linux
_linux_os() {
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

	rm -rf ~/.bashrc

	ln -s ~/.dotfiles/bashrc ~/.bashrc
	ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
	ln -s ~/.dotfiles/.git-completion.bash ~/.git-completion.bash
	ln -s ~/.dotfiles/welcome-terminal.txt ~/.welcome-terminal.txt
}

# Mac OS Darwin
_darwin_os() {
    _clearExistingFiles

    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

	ln -s ~/.dotfiles/bashrc ~/.bashrc
	ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
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
_clearExistingFiles() {
    rm -rf ~/.bashrc
    rm -rf ~/.vimrc
    rm -rf ~/.bash_profile
    rm -rf ~/.git-completion.bash
    rm -rf ~/.welcome-terminal.txt
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
