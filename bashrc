# .aliasrc
	# ~/.bashrc: executed by bash(1) for non-login shells.
	# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
	# for examples

alias ls='ls -G --color=auto'
alias rm='rm -i'
alias ll='ls -alhF --color=auto'
alias tree='tree -C'

# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"
# export JAVA_HOME=$(/usr/libexec/java_home)
# export PATH="/usr/local/opt/maven@3.3/bin:$PATH"
# export PATH="/usr/local/opt/maven@3.5/bin:$PATH"

# ######################################## Python ########################################
# Version Manager
#eval "$(pyenv init -)"

# Pip (Package) Python Manager
#eval "$(pipenv --completion)"

# pyenv
# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv virtualenv-init -)"

# export PATH="/usr/local/sbin:$PATH"
# export BASH_SILENCE_DEPRECATION_WARNING=1

# adding libclang for compile JS (SpiderMonkey)
export LIBCLANG_PATH="/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
export PATH="/usr/local/opt/llvm/bin:$PATH"

# Load Angular CLI autocompletion.
# source <(ng completion script)
