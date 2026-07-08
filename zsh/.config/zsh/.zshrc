if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

export SHELL_STYLE="simple"
autoload -U colors && colors
# Interactive Options
setopt PROMPT_SUBST
setopt AUTO_CD
setopt SHARE_HISTORY

newline=false
precmd() {
    if [ "$newline" = false ] ; then
        newline=true
    else
        print -rP "%(1j.%F{008}[%j] %f.)"
    fi
}

PROMPT='%n@%m:%F{013}%1~%f %# '
function set-prompt () {
    case ${KEYMAP} in
      (vicmd)      VI_MODE="%F{004}#%f" ;;
      (main|viins) VI_MODE="%%" ;;
      (*)          VI_MODE="%%" ;;
    esac
    PS1="%n@%m:%F{013}%1~%f $VI_MODE "
}

# hide cursor until next prompt ready
hide_cursor() { print -n "\e[?25l" }
show_cursor() { print -n "\e[?25h" }

function zle-line-init zle-keymap-select {
    set-prompt
	show_cursor
    zle reset-prompt
}

zle -N zle-line-finish hide_cursor
zle -N zle-line-init 
zle -N zle-keymap-select

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
zstyle ':completion:*' cache-path "$_comp_dump"
zmodload zsh/complist
_comp_options+=(globdots) 

# Keybindings
export KEYTIMEOUT=1
bindkey -v
bindkey -M viins '^H' backward-delete-char 
bindkey -M viins '^P' up-line-or-history 
bindkey -M viins '^N' up-line-or-history
bindkey -M menuselect '^I' forward-char      # Tab: cycle forward
bindkey -M menuselect '^[[Z' backward-char   # Shift-Tab: cycle backward

source "$ZDOTDIR/fzf-static.zsh"
source "$ZDOTDIR/funcs"
source "$ZDOTDIR/alias"
source "$ZDOTDIR/fzf-shell.zsh"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
