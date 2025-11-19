# FZF stuff
export FZF_DEFAULT_COMMAND='fd --type file --hidden'
export FZF_DEFAULT_OPTS='--highlight-line --no-scrollbar --margin="5%" --border=none --preview-window=border-line --color="16,bg:-1,bg+:-1"'
export FZF_TMUX=0
export FZF_CTRL_T_OPTS=
export FZF_CTRL_R_OPTS=

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--info=inline'

# Options for path completion (e.g. vim **<TAB>)
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'

# Options for directory completion (e.g. cd **<TAB>)
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# Search shell history with fzf
__fh() {
  local selected_command
  local query="$LBUFFER$RBUFFER"

  selected_command=$(
    fc -l 1 |
      awk 'NR>0 { 
        $1=""; # Remove the line number
        command_line = substr($0, 2); # Get command, remove leading space
        if (!a[command_line]++) { # Deduplicate
          print command_line 
        }
      }' |
      fzf --height=20% --layout=reverse --border=none --margin=0 --prompt="cmd: " --tac \
        --bind "ctrl-w:backward-kill-word" \
        --query "$query"
  )
  
  if [[ -n "$selected_command" ]]; then
    BUFFER="$selected_command"
    zle .end-of-line
  fi
  
  zle redisplay
}

zle -N __fh
bindkey '^R' __fh
