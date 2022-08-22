#!/bin/sh
if [ -z "$SSH_AGENT_PID" ] && [ -z "$SSH_AUTH_SOCK" ]; then
  if ! [ -e /tmp/ssh-agent-$USER ]; then
    ssh-agent 2>/dev/null >/tmp/ssh-agent-$USER
  fi
  . /tmp/ssh-agent-$USER >/dev/null
fi

# go
export GOPATH="/home/vladh/go"
export PATH=$PATH:"${GOPATH}/bin"

# hare
export PATH=$PATH:"/home/vladh/sources/qbe"
export PATH=$PATH:"/home/vladh/sources/harec/build"
export PATH=$PATH:"/home/vladh/sources/hare/.bin"
export HAREPATH="/home/vladh/sources/hare"
