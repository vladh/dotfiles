#!/bin/sh

c_black=`tput setaf 0`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_yellow=`tput setaf 3`
c_blue=`tput setaf 4`
c_magenta=`tput setaf 5`
c_cyan=`tput setaf 6`
c_white=`tput setaf 7`
c_reset=`tput sgr0`
c_bold=`tput bold`

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
  export PS1="\[$c_blue\]\u \[$c_magenta\]\h\[$c_blue\] \W\$(git_prompt)\$(venv_prompt)$prompt_char \[$c_reset\]"
else
  export PS1="$c_blue$(whoami) $c_red$(hostname)$c_blue $(basename $(pwd))\$(git_prompt)\$(venv_prompt)$prompt_char $c_reset"
fi
