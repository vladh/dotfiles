#!/bin/sh -eu

for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload topbar 2>&1 | tee -a /tmp/polybar.log & disown
done