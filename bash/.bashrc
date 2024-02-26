# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

PS1="\[\033[01;37m\] \$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi) $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\u@\h'; fi)\[\033[01;34m\] \w \$\[\033[00m\] "

export EDITOR='vim'
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

alias ......="cd ../../../../.."
alias .....="cd ../../../.."
alias ....="cd ../../.."
alias ...="cd ../.."
alias ..="cd .."
alias bashrc="vim ~/.bashrc"
alias d='du -sh'
alias g='git'
alias gcd='git checkout develop'
alias gcm='git checkout main'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gss='git status -s'
alias gst='git status'
alias l='ls -alh'
alias rsync-copy='rsync -avz --progress -h'
alias rsync-move='rsync -avz --progress -h --remove-source-files'
alias rsync-synchronize='rsync -avzu --delete --progress -h'
alias rsync-update='rsync -avzu --progress -h'
alias so="source ~/.bashrc"

# Set the correct file and directory permissions
function chmodfiles() {
  find $1 -type f -print0 | xargs -0 chmod 0644
}

function chmoddirs() {
  find $1 -type d -print0 | xargs -0 chmod 0755
}

# User specific aliases and functions
