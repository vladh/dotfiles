#!/bin/sh

if [ "$(uname)" = "FreeBSD" ]; then
  c_red='\e[0;31m'
  c_alsored='\e[0;31m'
  c_green='\e[0;32m'
  c_yellow='\e[1;33m'
  c_blue='\e[0;34m'
  c_purple='\e[0;35m'
  c_reset='\e[0m'
  c_bold=`tput bold`
else
  c_red=`tput setaf 1`
  c_alsored=`tput setaf 6`
  c_green=`tput setaf 2`
  c_yellow=`tput setaf 3`
  c_blue=`tput setaf 4`
  c_purple=`tput setaf 5`
  c_reset=`tput sgr0`
  c_bold=`tput bold`
fi

if [ "$(uname)" = "Darwin" ] || [ "$(uname)" = "Linux" ] || [ "$(uname)" = "FreeBSD" ]; then
  prompt_char="$"
else
  prompt_char=">"
fi

git_prompt() {
  git_branch="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
  if [ -n "$git_branch" ]; then
    echo ":${git_branch} "
  fi
}

venv_prompt() {
  if [ -n "${VIRTUAL_ENV}" ]; then
    echo "venv "
  fi
}

if [ -n "$BASH$FISH_VERSION" ]; then
  # Colours are enclosed in \[...\] so that they don't count towards the
  # character count and mess up scrolling etc.
  # PS1 used to be prefixed with: \[\033[G\]
  # What is that?
  export PS1="\[$c_blue\]\u \[$c_red\]\h\[$c_blue\] \W\$(git_prompt)\$(venv_prompt)\[$c_blue\]$prompt_char \[$c_reset\]"
else
  export PS1="$c_blue$(whoami) $c_red$(hostname)$c_blue $(basename $(pwd))\$(git_prompt)\$(venv_prompt)$c_blue$prompt_char $c_reset"
fi
