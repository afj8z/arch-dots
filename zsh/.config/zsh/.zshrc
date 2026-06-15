# ~/.zshrc
if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

# Interactive Options
setopt prompt_subst
setopt AUTO_CD
setopt SHARE_HISTORY

# Prompt
NEWLINE=$'\n'
prompt='%(1j.%F{15}[%j] %f.)'${NEWLINE}"[%F{magenta}%~%F{red}%f]$%b "
# No cursor blinking, needed in some terminals
# precmd() { print -n '\e[2 q'; }

# for the mvd() function TODO: Find more elegant solution (maybe? I dont hate it to much)
if [[ -f "$ZDOTDIR/.bound_dir" ]]; then
  export MVD="$(<"$ZDOTDIR/.bound_dir")"
fi

# History
CACHE="$HOME/.local/share/zsh"
HISTFILE="$CACHE/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# Completion
typeset -U fpath
fpath=("$ZDOTDIR/completions" $fpath)
autoload -Uz compinit
_comp_dump="$CACHE/.zcompdump"
setopt auto_menu menu_complete
setopt globdots
setopt extended_glob
setopt auto_param_slash

# NOTE: -C for speed, but requires running alias 'fixcomp' to add new completion
compinit -C -d "$_comp_dump"

# Completion Styles
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' menu select interactive
zstyle ':completion:*' group-name ''
zstyle ':completion:*' increment yes
zstyle ':completion:*' verbose yes
zstyle ':completion:*' squeeze-slashes yes 
zstyle ':completion:*' list-dirs-first yes
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" 
zstyle ':completion:*' rehash false 
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "$CACHE/.zcompcache"

zmodload zsh/complist
_comp_options+=(globdots) 

# Keybindings
# Reduce Esc delay to 10ms
export KEYTIMEOUT=1
bindkey -v
bindkey '^[[1;5D' backward-word # Ctrl-Left
bindkey '^[[1;5C' forward-word  # Ctrl-Right
bindkey -M viins '^W' backward-kill-word 
bindkey -M viins '^?' backward-delete-char 
bindkey -M viins '^H' backward-delete-char 
bindkey -M viins '^P' up-line-or-history 
bindkey -M viins '^N' up-line-or-history
bindkey -M menuselect '^I' forward-char      # Tab: cycle forward
bindkey -M menuselect '^[[Z' backward-char   # Shift-Tab: cycle backward

# Function to toggle back to the last background process
fancy-ctrl-z() {
  if [[ $#BUFFER -eq 0 ]]; then
    local jobs_count=$(jobs | wc -l)
    if [[ $jobs_count -eq 0 ]]; then
      # Trigger something if no job? 
      # BUFFER="ls" 
      return
    elif [[ $jobs_count -eq 1 ]]; then
      BUFFER="fg"
      zle accept-line
    else
      # Show jobs and pick or just fg the last one
      echo
      jobs
      BUFFER="fg"
      zle accept-line
    fi
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Sourcing
source "$ZDOTDIR/fzf-static.zsh"
source "$ZDOTDIR/direnv-hook.zsh"

source "$ZDOTDIR/funcs"
source "$ZDOTDIR/alias"
source "$ZDOTDIR/fzf-shell.zsh"


# Syntax highlighting: Always load LAST
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi

