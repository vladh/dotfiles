#!/bin/bash

youtube-dl -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' "$1"
