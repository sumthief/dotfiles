# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Define bash aliases in separate file.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable bash completion.
source /etc/bash/bashrc.d/bash_completion.sh

# Determine git branch.
function git_branch() {
 git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /' 
}

export PS1="\[$(tput bold)\]\[\033[38;5;121m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;74m\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;105m\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput bold)\]\[\033[38;5;208m\]\$(git_branch)$\[$(tput sgr0)\] " 

# Goes inside docker container
# Example of usage: docker_exec prjname_mariadb
function docker_exec() {
 docker exec -it $(docker ps -q -f name="$1") /bin/sh
}

# Completely stop docker container
# Example of usage: docker_stop prjname_php
# Or if you want to stop all containers for current prj: docker_stop prjname
function docker_stop() {
 docker stop $(docker ps -q -a -f name="$1") && docker rm $(docker ps -q -a -f name="$1")
}

# Start project based on docker containers.
export PRJ_PATH="$HOME/prj"
function prj_start() {
 CURRENT_PWD=$(pwd)
 if [ -d "$PRJ_PATH/$1/provision" ]; then
  cd $PRJ_PATH/$1/provision && docker-compose up -d
 fi
 cd $CURRENT_PWD
}

# Full system update
alias system_update="sudo emerge --sync && sudo emerge -avuDN @world"
