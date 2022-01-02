#!/bin/sh

export ENV=$HOME/.env
export EDITOR=vim
export CLICOLOR=1
export LANG=en_US.UTF-8
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export LS_COLORS="ow=01;36;40"

if [ -n "$BASH" ]; then
  shopt -s histappend
  # This history is used for reverse-search and so on
  export HISTFILESIZE=
  export HISTSIZE=
  export HISTTIMEFORMAT="%F %T "
  export HISTFILE=~/.history
  # This saves logs to consult later
  export PROMPT_COMMAND='history -a && echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> $HOME/.logs/sh-history-$(date "+%Y-%m-%d").log'
fi

. $HOME/.bin/lib/prompt
[ -n "$BASH" ] && . $HOME/.env
[ -e $HOME/.bin/hosts/$(hostname).profile ] && . $HOME/.bin/hosts/$(hostname).profile
. $HOME/.bin/lib/z.sh
