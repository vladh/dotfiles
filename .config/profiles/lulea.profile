#!/bin/sh

if [ -z "$SSH_AGENT_PID" ] && [ -z "$SSH_AUTH_SOCK" ]; then
  if ! [ -e /tmp/ssh-agent-$USER ]; then
    ssh-agent 2>/dev/null >/tmp/ssh-agent-$USER
  fi
  . /tmp/ssh-agent-$USER >/dev/null
fi

[ -f $HOME/.fzf.bash ] && . $HOME/.fzf.bash

# c
export CPATH=$CPATH:"/usr/include/SDL2"

# rust
. "$HOME/.cargo/env"

# go
export GOPATH="/home/vladh/go"
export PATH=$PATH:"/usr/local/go/bin:/home/vladh/go/bin"

# hare
export PATH=$PATH:"/home/vladh/proj-versioned/qbe/obj"
export PATH=$PATH:"/home/vladh/proj-versioned/harec/build"
export PATH=$PATH:"/home/vladh/proj-versioned/hare/.bin"
export HAREPATH="/home/vladh/proj-versioned/hare"

# uxn
export PATH=$PATH:"/home/vladh/proj-versioned/uxn/bin"

# zig
export PATH=$PATH:"/home/vladh/.local/opt/zig-linux-x86_64-0.8.1"
