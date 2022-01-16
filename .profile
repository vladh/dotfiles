#!/bin/sh
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
  export PROMPT_COMMAND='history -a && echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> $HOME/.logs/sh-history-$(date "+%Y-%m-%d").log'

  # z.sh unfortunately only works under bash
  . $HOME/.bin/lib/z.sh
fi

export EDITOR=vim
export CLICOLOR=1
export LANG=en_US.UTF-8
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export LS_COLORS="ow=01;36;40"
export PATH="${HOME}/.bin:${HOME}/.local/bin:${PATH}"
export FZF_DEFAULT_COMMAND="fd -j1 --type f -H -E .git"
export PYTHONIOENCODING=utf-8

alias grep="grep --color"
alias tmux="TERM=xterm-256color tmux"
alias ta="tmux attach -t"
alias tl="tmux ls"

uname_str="$(uname)"
if [ "${uname_str#*Darwin}" != "$uname_str" ]; then
  # BSD ls
  alias ls='ls -G'
  alias ll="ls -lhaG"
else
  # GNU ls
  alias ls='ls --color --group-directories-first'
  alias ll="ls -lha --color --group-directories-first"
fi

[ -e $HOME/.config/profiles/$(hostname).profile ] && . $HOME/.config/profiles/$(hostname).profile
