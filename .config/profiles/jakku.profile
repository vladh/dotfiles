#!/bin/sh -eu

eval $(keychain -q --agents ssh --eval id_rsa)
