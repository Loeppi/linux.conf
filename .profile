# loeppi
umask 0077
export LANG=de_DE.UTF-8
export LANGUAGE=de_DE.UTF-8
export LC_LANG=de_DE.UTF-8
export PATH=$PATH:~/.loeppi/bin/

# history
export HISTFILE=~/.bash_history
export HISTFILESIZE=4000
export HISTSIZE=1000
export HISTIGNORE="cd:ls:ll:exit"
export HISTCONTROL=erasedups:ignoredups:ignorespace
shopt -s histappend

# latex
export MANPATH=/usr/share/texlive/texmf-dist/doc/:$MANPATH

# export PATH=$PATH:/opt/ka/tex/2015/bin/x86_64-linux/
# export TEXDIR=/opt/ka/tex/2015/
# export TEXMFLOCAL=/opt/ka/tex/texmf-local/
# export TEXMFSYSVAR=/opt/ka/tex/2015/texmf-var/
# export TEXMFSYSCONFIG=/opt/ka/tex/2015/texmf-config/

# latex-personal 
# export TEXMFVAR=~/.config/tex/texlive/2016/texmf-var/
# export TEXMFCONFIG=~/.config/tex/texlive/2016/texmf-config/
# export TEXMFHOME=~/.config/tex/texmf/
