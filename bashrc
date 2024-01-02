# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/bashrc.pre.bash" ]] && builtin source "$HOME/.fig/shell/bashrc.pre.bash"
# .aliasrc
	# ~/.bashrc: executed by bash(1) for non-login shells.
	# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
	# for examples

alias ls='ls -G --color=auto'
alias rm='rm -i'
alias ll='ls -alhF --color=auto'
alias tree='tree -C'

# ######################################## NodeJS ########################################
# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# ######################################## Java ########################################
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

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

# ######################################## Ruby ########################################
if [[ -s $HOME/.rvm/scripts/rvm ]]; then
  source $HOME/.rvm/scripts/rvm;
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# adding libclang for compile JS (SpiderMonkey)
export LIBCLANG_PATH="/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
export PATH="/usr/local/opt/llvm/bin:$PATH"

# Load Angular CLI autocompletion.
# source <(ng completion script)

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bashrc.post.bash" ]] && builtin source "$HOME/.fig/shell/bashrc.post.bash"
