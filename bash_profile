# .aliasrc

alias ls='ls -G'
alias rm='rm -i'
alias ll='ls -alhF'
alias tree='tree -C'

# Alias Intellij Mac
alias idea='open -a "`ls -dt /Applications/IntelliJ\ IDEA*|head -1`"'


# Setting GIT prompt
c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

branch_color ()
{
    if git rev-parse --git-dir >/dev/null 2>&1
    then
        color=""
        if git diff --quiet 2>/dev/null >&2
        then
           color=${c_red}
        else
          color=${c_green}
        fi
    else
        return 0
    fi
    echo -n $color
}

parse_git_branch ()
{
    if git rev-parse --git-dir >/dev/null 2>&1
    then
      gitver=" ("$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')")"
    else
        return 0
    fi
echo -e $gitver
}

#It's important to escape colors with \[ to indicate the length is 0
PS1='${c_green}\u@\[ \]\W\[\]\[\[$(branch_color)\] $(parse_git_branch)\[\]${c_sgr0}\n$ '

source ~/.git-completion.bash
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# NVM
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

# Python Version Manager
#eval "$(pyenv init -)"

# Pip (Package) Python Manager
#eval "$(pipenv --completion)"

# RVM for Ruby
if [[ -s $HOME/.rvm/scripts/rvm ]]; then
  source $HOME/.rvm/scripts/rvm;
fi

# adding libclang for compile JS (SpiderMonkey)
export LIBCLANG_PATH="/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
export PATH="/usr/local/opt/llvm/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="/usr/local/opt/maven@3.3/bin:$PATH"
export PATH="/usr/local/opt/maven@3.5/bin:$PATH"

# For pyenv
eval "$(pyenv init -)"

export PATH="/usr/local/sbin:$PATH"
export BASH_SILENCE_DEPRECATION_WARNING=1

