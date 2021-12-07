# .aliasrc

alias ls='ls -G --color=auto'
alias rm='rm -i'
alias ll='ls -alhF --color=auto'
alias tree='tree -C'

# Alias Intellij Mac
alias idea='open -a "`ls -dt /Applications/IntelliJ\ IDEA*|head -1`"'

# Setting GIT prompt
c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`
c_blue=`tput setaf 4`

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

# Run on terminal starts
cat ~/.welcome-terminal.txt

#It's important to escape colors with \[ to indicate the length is 0
PS1='\e[0;36m\[(\t)\] ${c_green}\u@\[ \]\W\[\]\[\[$(branch_color)\] $(parse_git_branch)\[\]${c_sgr0}\n$ '

# Git completion for bash
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Python Version Manager
#eval "$(pyenv init -)"

# Pip (Package) Python Manager
#eval "$(pipenv --completion)"

# RVM for Ruby
if [[ -s $HOME/.rvm/scripts/rvm ]]; then
  source $HOME/.rvm/scripts/rvm;
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# For pyenv
eval "$(pyenv init -)"

export PATH="/usr/local/sbin:$PATH"
export BASH_SILENCE_DEPRECATION_WARNING=1

