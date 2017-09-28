#!/bin/bash
# The dotfile initial

echo "Creating .bash_profile"
ln -s ~/.dotfiles/.bash_profile ~/

# Mac OS X Darwin
#_darwin_os() {
#}

# Common functions
#_dotfile() {
#}

# Get the OS Name
os_name=$(uname -s)

#if [ $os_name == "Darwin" ] then
#  _darwin_os
#else
#  _linux_os
#fi

