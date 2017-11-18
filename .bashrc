export BASH_ENV='~/.bashrc'
xrdb -merge $HOME/.loeppi/config/.Xdefaults
shopt -s histappend

if [ -f /usr/share/autojump/autojump.bash ]; then
    . /usr/share/autojump/autojump.bash
fi

if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.loeppi/hosts ]; then
    complete -W "$(cat ~/.loeppi/hosts)" ssh
fi

if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
  . /usr/share/git-core/contrib/completion/git-prompt.sh
  export PS1='\n\u@\h: \w\n$(__git_ps1 "(%s)")(\!) \$ '
elif [ -f /usr/lib/git-core/git-sh-prompt ]; then
  . /usr/lib/git-core/git-sh-prompt
  export PS1='\n\u@\h: \w\n$(__git_ps1 "(%s)")(\!) \$ '
else
  export PS1='\n\u@\h: \w\n(\!) \$ '
fi

if test "$UID" -eq 0 -a -t ; then
  _bred="$(tput bold 2> /dev/null; tput setaf 1 2> /dev/null)"
  _sgr0="$(tput sgr0 2> /dev/null)"
  PS1="\[$_bred\]$PS1\[$_sgr0\]"
  unset _bred _sgr0
else
  _bred="$(tput bold 2> /dev/null; tput setaf 4 2> /dev/null)"
  _sgr0="$(tput sgr0 2> /dev/null)"
  PS1="\[$_bred\]$PS1\[$_sgr0\]"
  unset _bred _sgr0
fi

if [ -f /usr/bin/xhost ]; then
  xhost + >> /dev/null
fi

