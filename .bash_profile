# .aliasrc

alias ls='ls -G'
alias rm='rm -i'
alias ll='ls -alF'
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
PS1='${c_green}\u@\[ \]\W\[\]\[\[$(branch_color)\] $(parse_git_branch)\[\]${c_sgr0}\nλ '

source ~/.git-completion.bash

# NVM
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"
