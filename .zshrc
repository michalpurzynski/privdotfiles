export ZSH=$HOME/.zsh

autoload -U compinit promptinit
autoload -U colors && colors
autoload -U compaudit
autoload -Uz is-at-least

setopt completealiases
setopt HIST_IGNORE_DUPS

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

ttyctl -f

fpath=($ZSH/zsh-completions/src $fpath)

ZSH_CUSTOM="$ZSH/custom"
ZSH_CACHE_DIR="$ZSH/cache/"

is_plugin() {
  local base_dir=$1
  local name=$2
  test -f $base_dir/plugins/$name/$name.plugin.zsh \
    || test -f $base_dir/plugins/$name/_$name
}
# Add all defined plugins to fpath. This must be done
# before running compinit.
for plugin ($plugins); do
  if is_plugin $ZSH_CUSTOM $plugin; then
    fpath=($ZSH_CUSTOM/plugins/$plugin $fpath)
  elif is_plugin $ZSH $plugin; then
    fpath=($ZSH/plugins/$plugin $fpath)
  fi
done

# Figure out the SHORT hostname
if [[ "$OSTYPE" = darwin* ]]; then
  # OS X's $HOST changes with dhcp, etc. Use ComputerName if possible.
  SHORT_HOST=$(scutil --get ComputerName 2>/dev/null) || SHORT_HOST=${HOST/.*/}
else
  SHORT_HOST=${HOST/.*/}
fi

if [ -z "$ZSH_COMPDUMP" ]; then
  ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi

compinit -d "${ZSH_COMPDUMP}" -u

plugins=(brew brew-cask colored-man-pages colorize common-aliases cp history-substring-search jsontools nmap pip rsync screen supervisor systemd ubuntu git zsh-syntax-highlighting gitfast)
# aws vagrant

for plugin ($plugins); do
    source $ZSH/$plugin/$plugin.plugin.zsh
done

promptinit

source "$ZSH/robbyrussell.zsh"

autoload -U colors && colors
setopt promptsubst
source $ZSH/git.zsh

cmd_exists () {
    type "$1" &> /dev/null ;
}

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

[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

alias bro-column="sed \"s/fields.//;s/types.//\" | column -s $'\t' -t"

export GOPATH="$HOME/go
