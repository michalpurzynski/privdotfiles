export ZSH=~/.zsh
ZSH_THEME=afowler

autoload -U compinit promptinit
autoload -U colors && colors

compinit
promptinit
prompt redhat

setopt completealiases
setopt HIST_IGNORE_DUPS

ttyctl -f

cmd_exists () {
    type "$1" &> /dev/null ;
}

plugins=(git zsh-syntax-highlighting osx)

export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/MacGPG2/bin

if cmd_exists keychain ; then
    eval `keychain --eval --agents ssh --inherit any`
    #eval `gpg-agent --enable-ssh-support --daemon --write-env-file ~/.gnupg/.agent_env`
    #source ~/.gnupg/.agent_env
fi
gnupginf="${HOME}/.gpg-agent-info"
if cmd_exists gpg-agent; then
    if pgrep -u "${USER}" gpg-agent >/dev/null 2>&1; then
        eval `cat $gnupginf`
        eval `cut -d= -f1 $gnupginf | xargs echo export`
    else
        #eval `gpg-agent -s --enable-ssh-support --daemon --write-env-file $gnupginf`
        eval `gpg-agent -s --daemon --write-env-file $gnupginf`
    fi
fi

BROPATH="/opt/bro/bin"
if [ -d "${BROPATH}" ]; then
    PATH=$BROPATH:$PATH
fi
MYRIPATH="/opt/snf"
if [ -d "${MYRIPATH}" ]; then
    PATH=$MYRIPATH:$PATH;
fi
export PATH=/usr/local/openssh/bin:/usr/local/bin:/usr/local/sbin:$PATH

EDITOR=vim
VISUAL=$EDITOR
SVN_EDITOR=$EDITOR

export EDITOR VISUAL SVN_EDITOR

fpath=(/usr/local/share/zsh-completions $fpath)

export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

alias lpass-moz="HOME=~/.lp-moz lpass"

export ANSIBLE_HOSTS=~/.ansible_hosts
