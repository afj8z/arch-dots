# ~/.zshrc

# --- Interactive Options ---
autoload -U colors && colors
setopt prompt_subst
setopt AUTO_CD
setopt SHARE_HISTORY

# --- Prompt ---
prompt="[%F{magenta}%~%F{red}%f]$%b "

# No cursor blinking
precmd() { print -n '\e[2 q'; }

# --- Local/Session Logic ---
if [[ -f "$ZDOTDIR/.bound_dir" ]]; then
  export MVD="$(<"$ZDOTDIR/.bound_dir")"
fi

# --- History ---
CACHE="$HOME/.local/share/zsh"
HISTFILE="$CACHE/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# --- Completion ---
autoload -U compinit
# Check if dump exists and is younger than .zshrc
if [[ ! -s $CACHE/.zcompdump || $CACHE/.zcompdump -ot $ZSHRC ]]; then
  compinit -d "$CACHE/.zcompdump"
else
  compinit -C -d "$CACHE/.zcompdump"
fi

# Completion Styles
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' menu select 
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

# --- Keybindings ---
bindkey -v
bindkey '^[[1;5D' backward-word # Ctrl-Left
bindkey '^[[1;5C' forward-word  # Ctrl-Right

# --- Sourcing ---
source <(fzf --zsh)

source "$ZDOTDIR/funcs"
source "$ZDOTDIR/alias"
source "$ZDOTDIR/fzf-shell.zsh"

# direnv hook
eval "$(direnv hook zsh)"

# Syntax highlighting (Always load this LAST)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
