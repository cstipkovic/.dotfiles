# .bash_profile

# Alias
alias ls='ls -G'
alias ll='ls -lG'
alias rm='rm -i'

# Get Git Branch
_get_git_branch() {
  echo git branch
}

export PS1='\w \[\033[031m\] ($_get_git_branch)\n$ '

#export PS1='\w \[\033[31m\]\'ruby -e \print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\'\[\033[37m\]$\[\033[00m\] \n$ '
