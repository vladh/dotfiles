#!/bin/sh -eu

killall -q polybar || true
polybar topbar 2>&1 | tee -a /tmp/polybar.log & disown
