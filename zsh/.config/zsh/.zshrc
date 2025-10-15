# = Prompt and Keybindings
autoload -U colors && colors
bindkey -e

# Enable substitution in the prompt.
setopt prompt_subst
prompt="[%{$fg[magenta]%}%~%{$fg[red]%}%{$reset_color%}]$%b "
setopt AUTO_CD
setopt SHARE_HISTORY

if [[ -f "$ZDOTDIR/.bound_dir" ]]; then
  export MVD="$(<"$ZDOTDIR/.bound_dir")"
fi

# local vars
CACHE="$HOME/.local/share/zsh"
CONFIGDIR="$HOME/.config"
DEVDIR="$HOME/dev"

# Path
export PATH="$HOME/.local/bin:$HOME/bin/nvim/bin:$PATH"

# History
HISTFILE="$CACHE/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

source <(fzf --zsh)

# Completion
autoload -U compinit
if [[ ! -s $CACHE/.zcompdump || $CACHE/.zcompdump -ot $ZSHRC ]]; then
  compinit -d "$CACHE/.zcompdump"
else
  compinit -C -d "$CACHE/.zcompdump"
fi

# bindkey "^I" menu-complete 

zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' completer _complete
zstyle ':completion:*' menu select  # menu with selection
zstyle ':completion:*' group-name ''
zstyle ':completion:*' increment yes
zstyle ':completion:*' verbose yes
zstyle ':completion:*' squeeze-slashes yes  # replace // with /

zstyle ':completion:*' file-sort modification  # show recently used files first
zstyle ':completion:*' list-dirs-first yes
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # colored files and directories, blue selection box

zstyle ':completion:*' rehash false  # improves performance
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "$CACHE/.zcompcache"

zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.

# Keybindings
bindkey '^H' backward-word  # Control-Left
bindkey "^h" backward-char
bindkey '^L' forward-word  # Control-Right
bindkey "^l" forward-char
bindkey "^K" end-of-line
bindkey "^J" beginning-of-line
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
export FZF_DEFAULT_COMMAND='fd --type file --hidden'
export FZF_DEFAULT_OPTS='--margin="5%" --preview-window=border-line --color="16,bg:-1,bg+:-1"'


export FZF_TMUX=1
export FZF_TMUX_OPTS='-p 90%'

export BAT_THEME="ansi"

export TYPST_PACKAGE_PATH="$HOME/.typst"

# Aliases
alias q='exit'
alias zv="nvim $ZDOTDIR/.zshrc"
alias y="yazi"
alias zayi="echo learn to spell && sleep 3"
alias gs="git status"
alias gpl='git pull'
alias zrl='source $ZDOTDIR/.zshrc'
alias vi='nvim'
alias v='nvim'
alias ve='nvim .'
alias ll='ls -a --color=auto'
alias glry='feh -g 640x480 -d --scale-down -S filename'
alias poet='$(poetry env activate)'
alias gg="bg kys"
alias fz='fzf  --preview "bat --color=always {}" --preview-window "~3"'
alias la='ls -lha --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias fk="sudo !!"
alias rm="rm -Iv"
alias rmrf="rm -Ivrf"
alias mv="mv -i"
alias df="df -h" 
alias du="du -h -d 1" 
alias fp="ps aux | grep $1"
alias freem="free -h | bat -l cpuinfo -p"

# Functions
# Enter a directory and list its contents
cdl() {
  if [[ -d "$1" ]]; then
    builtin cd "$1" && ls -a --group-directories-first --color=auto
  else
    echo "Usage: cd <directory>"
  fi
}

# git push all with optional commit message
gpa() {
  git add .
  git commit -m "${1:-NoMsg}"
  git push
}

# Help function
# help messages
typeset -A __help
__help[gpa]="Add, commit, and push with optional message"
__help[cd]="Change to a directory and list it with ls - uses builtin cd command."


# Help function
help() {
  if [[ -n $1 ]]; then
    echo "${__help[$1]:-No help available for '$1'}"
  else
    for k in ${(k)__help}; do
      echo "$k: ${__help[$k]}"
    done
  fi
}

# Open current dir in yazi
finder() {
    yazi .
}

zle -N finder
bindkey '^e' finder

# mkdir and cd into it
mkcd() {
    local dir="$*";
    mkdir -p "$dir" && builtin cd "$dir";
}

# Append $1 to file $2
cap() {
	echo "$1" >> "$2"
}

# Bind PWD to $MVD
# .zshrc

mvd() {
  echo "$PWD" > "$ZDOTDIR/.bound_dir"
  export MVD="$PWD"
  echo "Bound MVD to: $MVD"
}

mvdot() {
	dotpath="$HOME/dotfiles/$1"
	newdots="$(echo $PWD/$1 | sed "s|^$HOME/||")"
	fullpath="$dotpath/$newdots"
	mkdir -p $fullpath
	mv $1 $fullpath
	(cd $HOME/dotfiles;/usr/bin/stow $1)
	echo "$1 moved to dotfiles in $fullpath \n\
		linked back to $PWD/$1 with stow."
}

cdr() {
  local dir=$(tmux run "echo '#{session_path}'")
  builtin cd "$dir"
}

lnpath() {
  if [ -z "$1" ]; then
    echo "Usage: lnpath <file>"
    echo "Creates a symlink for the given file in ~/.local/bin/"
    return 1
  fi

  local source_file="$1"
  local target_dir="$HOME/.local/bin"
  local filename=$(basename "$source_file")
  local target_path="$target_dir/$filename"

  mkdir -p "$target_dir"

  if [ -e "$target_path" ]; then
    echo "Warning: '$filename' already exists in $target_dir."
    read -q "REPLY?Do you want to overwrite it? (y/n) "
    echo

    if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
      echo "Operation cancelled."
      return 0
    fi
  fi

  local source_abspath
  source_abspath=$(realpath "$source_file")
  
  if [ ! -e "$source_abspath" ]; then
      echo "Error: Source file '$source_file' not found."
      return 1
  fi

  if [ ! -x "$source_abspath" ]; then
    chmod u+x "$source_abspath"
    echo "Applied chmod u+x to '$filename'."
  fi

  ln -sf "$source_abspath" "$target_path"

  echo "Success! Symlink created:"
  echo "$target_path -> $source_abspath"
}

mkwall() {
	gowall convert --dir ~/pictures/adjustee -t "${1:-mydark}" --output ~/pictures/wallpapers
}

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Options for path completion (e.g. vim **<TAB>)
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'

# Options for directory completion (e.g. cd **<TAB>)
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments ($@) to fzf.
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

precmd() {
  print -n '\e[2 q'
}

eval "$(direnv hook zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
