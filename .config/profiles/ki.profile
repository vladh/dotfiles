#!/bin/sh

if [ -z "$SSH_AGENT_PID" ] && [ -z "$SSH_AUTH_SOCK" ]; then
  if ! [ -e /tmp/ssh-agent-$USER ]; then
    ssh-agent 2>/dev/null >/tmp/ssh-agent-$USER
  fi
  . /tmp/ssh-agent-$USER >/dev/null
fi
