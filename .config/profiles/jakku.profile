#!/bin/sh

eval $(keychain -q --agents ssh --eval id_rsa)
. "$HOME/.cargo/env"
export PATH="${PATH}:/usr/local/go/bin"

export GOPATH="/home/vladh/go"

export PATH=$PATH:"/home/vladh/go/bin"
export PATH=$PATH:"/home/vladh/proj-versioned/qbe/obj"
export PATH=$PATH:"/home/vladh/proj-versioned/harec/build"
export PATH=$PATH:"/home/vladh/proj-versioned/hare/.bin"
export HAREPATH="/home/vladh/proj-versioned/hare"

export PATH=$PATH:"/home/vladh/.local/opt/zig-linux-x86_64-0.8.1"
