#!/bin/sh -eu
# This file is loaded for interactive login shells.

# Read the non-login shell config now, and when we launch future non-login
# shells
export ENV=$HOME/.env

if [ -n "$BASH$FISH_VERSION" ]; then
  . $ENV
  # Append to the HISTFILE as we go, not on exit
  shopt -s histappend
fi

[ -e $HOME/.config/profiles/$(hostname).profile ] && . $HOME/.config/profiles/$(hostname).profile
