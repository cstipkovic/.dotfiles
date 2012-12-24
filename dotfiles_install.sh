#!/bin/bash
# The dotfile initial

# Mac OS X Darwin
_darwin_os() {
  if [ ! -f ~/.bash_profile ] then
    curl -Lo ~/.git-completion.bash https://github.com/git/git/raw/master/contrib/completion/git-completion.bash
    source .git-completion.bash
    echo "Creating symbolyc link for .bash_profile"
    ln -s ~/.bash/.bash_profile ~/.bash_profile
    echo "source ~/.git-completion.bash" >> ~/.bash_profile
  else
    echo "Exists .bash_profile"
  fi

  #_dotfile
}

# GNU Linux
_linux_os() {
  echo "Linux"
  _dotfile
}

# Common functions
_dotfile() {
  if [ ! -f ~/.bashrc ] then
    echo "Creating symbolyc link for .bashrc"
    ln -s ~/.bash/.bashrc ~/.bashrc
  else
    echo "Exists .bashrc"
  fi
}

# Get the OS Name
os_name=$(uname -s)

if [ $os_name == "Darwin" ] then
  _darwin_os
else
  _linux_os
fi

