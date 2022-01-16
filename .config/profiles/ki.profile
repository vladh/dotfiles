#!/bin/sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# go
export GOPATH="/home/vladh/go"
export PATH=$PATH:"/usr/local/go/bin"

# hare
export PATH=$PATH:"/home/vladh/proj-versioned/qbe/obj"
export PATH=$PATH:"/home/vladh/proj-versioned/harec/build"
export PATH=$PATH:"/home/vladh/proj-versioned/hare/.bin"
export HAREPATH="/home/vladh/proj-versioned/hare"
