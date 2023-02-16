#!/bin/sh -eu
# This file is loaded for interactive login shells.

# Read the non-login shell config now, and when we launch future non-login
# shells
export ENV=$HOME/.env
[ -n "$BASH$FISH_VERSION" ] && . $HOME/.env

if [ -n "$BASH$FISH_VERSION" ]; then
  # Append to the HISTFILE as we go, not on exit
  shopt -s histappend
  # This history is used for reverse-search and so on
  export HISTFILESIZE=
  export HISTSIZE=
  export HISTTIMEFORMAT="%F %T "
  export HISTFILE=~/.history
  # This saves logs to consult later
  export PROMPT_COMMAND='history -a && echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> $HOME/.vladh/logs/sh-history-$(date "+%Y-%m-%d").log'
fi

[ -e $HOME/.config/profiles/$(hostname).profile ] && . $HOME/.config/profiles/$(hostname).profile
