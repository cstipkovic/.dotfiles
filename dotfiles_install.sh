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

# Mac OS X Darwin
_darwin_os() {
	ln -s ~/.dotfiles/bashrc ~/.bashrc
	ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
	ln -s ~/.dotfiles/bash_profile ~/.bash_profile
	ln -s ~/.dotfiles/.git-completion.bash ~/.git-completion.bash
	ln -s ~/.dotfiles/welcome-terminal.txt ~/.welcome-terminal.txt
}

if [ $os_name = "Darwin" ] 
then
	_darwin_os
else
	_linux_os
fi

echo "Getting Vim-Plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Common functions
_dotfile() {
	echo "dotfiles"
}
