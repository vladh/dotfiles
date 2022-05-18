#!/bin/sh

if [ -z "$SSH_AGENT_PID" ] && [ -z "$SSH_AUTH_SOCK" ]; then
  if ! [ -e /tmp/ssh-agent-$USER ]; then
    ssh-agent 2>/dev/null >/tmp/ssh-agent-$USER
  fi
  . /tmp/ssh-agent-$USER >/dev/null
fi

# c
export CPATH=$CPATH:"/usr/include/SDL2"
export LD_LIBRARY_PATH="${HOME}/.local/opt/Qt/6.1.3/gcc_64/lib:${LD_LIBRARY_PATH}"

# rust
[ -e $HOME/.cargo/env.profile ] && . "$HOME/.cargo/env"

# go
export GOPATH="/home/vladh/go"
export PATH=$PATH:"${GOPATH}/bin"

# hare
export PATH=$PATH:"/home/vladh/sources/qbe/obj"
export PATH=$PATH:"/home/vladh/sources/harec/build"
export PATH=$PATH:"/home/vladh/sources/hare/.bin"
export HAREPATH="/home/vladh/sources/hare"

# uxn
export PATH=$PATH:"/home/vladh/sources/uxn/bin"

# zig
export PATH=$PATH:"/home/vladh/.local/opt/zig-linux-x86_64-0.8.1"
