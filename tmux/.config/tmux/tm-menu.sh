#!/usr/bin/env bash

# Fetch sessions: name|id
sessions=$(tmux list-sessions -F "#S")

cmd="tmux display-menu -T ' Sessions' -x C -y C"

key=1
while IFS='|' read -r name; do
    cmd+=" '$name' '$key' 'switch-client -t $name'"
	((key++))
done <<< "$sessions"

 # Menu separator
 cmd+=" ''" 
 

 cmd+=" 'Notes' 'N' 'new-session -d -s notes -c ~/notes ; switch-client -t notes'"
 # Cheeky width padding
 cmd+=" 'Config                           ' 'C' 'new-session -d -s config -c ~/.config ; switch-client -t config'"
 cmd+=" 'Dotfiles' 'D' 'new-session -d -s dotfiles -c ~/arch-dots ; switch-client -t dotfiles'"
 cmd+=" 'Nvim' 'V' 'new-session -d -s nvim -c ~/nvim/nvim/.config/nvim ; switch-client -t nvim'"

eval "$cmd"
