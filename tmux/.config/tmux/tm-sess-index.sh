#!/usr/bin/env bash

# $1 is the index number passed from the keybinding
INDEX=$1

# Get the session name corresponding to that index line number
TARGET=$(tmux list-sessions -F "#{session_name}" | sed -n "${INDEX}p")

if [ -n "$TARGET" ]; then
    tmux switch-client -t "$TARGET"
else
    tmux display-message "Session $INDEX does not exist."
fi
