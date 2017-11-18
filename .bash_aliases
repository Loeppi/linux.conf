#!/bin/bash

alias ls='/bin/ls -F --color=always'
alias ll='/bin/ls -lhvBF --color=always'
alias la='/bin/ls -lhvaBF --color=always'
alias ..='cd ..'
alias up='cd ..'
alias upp='cd ../..'
alias uppp='cd ../../..'
alias du1='/usr/bin/du -h --max-depth=1 .'
alias doch='history -s sudo $(history -p \!\!) && sudo $(history -p \!\!)'

function mcd {
    mkdir -p "$1"
    cd "$1"
}
