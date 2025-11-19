# Prompt and Keybindings
autoload -U colors && colors
bindkey -v

# Enable substitution in the prompt
setopt prompt_subst
prompt="[%{$fg[magenta]%}%~%{$fg[red]%}%{$reset_color%}]$%b "
setopt AUTO_CD
setopt SHARE_HISTORY

# No cursor blinking in the prompt
precmd() {
  print -n '\e[2 q'
}

if [[ -f "$ZDOTDIR/.bound_dir" ]]; then
  export MVD="$(<"$ZDOTDIR/.bound_dir")"
fi

# local vars
CACHE="$HOME/.local/share/zsh"
CONFIGDIR="$HOME/.config"
DEVDIR="$HOME/dev"

# Path
export PATH="$HOME/.local/bin:$HOME/bin/nvim/bin:$HOME/.cargo/bin/:$PATH"

# History
HISTFILE="$CACHE/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# Completion
autoload -U compinit
if [[ ! -s $CACHE/.zcompdump || $CACHE/.zcompdump -ot $ZSHRC ]]; then
  compinit -d "$CACHE/.zcompdump"
else
  compinit -C -d "$CACHE/.zcompdump"
fi

zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' menu select  # menu with selection
zstyle ':completion:*' group-name ''
zstyle ':completion:*' increment yes
zstyle ':completion:*' verbose yes
zstyle ':completion:*' squeeze-slashes yes  # replace // with /

zstyle ':completion:*' list-dirs-first yes
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # colored files and directories, blue selection box

zstyle ':completion:*' rehash false  # improves performance
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "$CACHE/.zcompcache"

zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.

# Keybindings
bindkey '^[[1;5D' backward-word  # Control-Left
bindkey '^[[1;5C' forward-word  # Control-Right

# Locale and Environment
export LANG=en_US.UTF-8
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

# Editors and Tools
export MANPAGER="nvim +Man!"
export EDITOR='nvim'
export BAT_THEME="ansi"
export TYPST_PACKAGE_PATH="$HOME/.typst"

source <(fzf --zsh)

source "$ZDOTDIR/funcs"
source "$ZDOTDIR/alias"
source "$ZDOTDIR/smart-history.zsh"
source "$ZDOTDIR/fzf-shell.zsh"
eval "$(direnv hook zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
