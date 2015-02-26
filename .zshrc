# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="afowler"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

cmd_exists () {
    type "$1" &> /dev/null ;
}

plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

autoload -U colors && colors

# Customize to your needs...
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/MacGPG2/bin

#if cmd_exists keychain ; then
#    eval `keychain --eval --agents ssh --inherit any`
#    #eval `gpg-agent --enable-ssh-support --daemon --write-env-file ~/.gnupg/.agent_env`
#    #source ~/.gnupg/.agent_env
#fi
#gnupginf="${HOME}/.gpg-agent-info"
#if cmd_exists gpg-agent; then
#    if pgrep -u "${USER}" gpg-agent >/dev/null 2>&1; then
#        eval `cat $gnupginf`
#        eval `cut -d= -f1 $gnupginf | xargs echo export`
#    else
#        #eval `gpg-agent -s --enable-ssh-support --daemon --write-env-file $gnupginf`
#        eval `gpg-agent -s --daemon --write-env-file $gnupginf`
#    fi
#fi

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

