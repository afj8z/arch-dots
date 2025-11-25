# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Zsh Configuration Directory
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

# Path Management
# typeset -U no duplicate entries
typeset -U path PATH
path=(
    "$HOME/.local/bin"
    "$HOME/bin/nvim/bin"
    "$HOME/.cargo/bin"
    $path
)
export PATH

# Defaults
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export PAGER="/bin/less"
export MANPAGER="nvim +Man!"

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Tool-Specific
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export PYTHON_HISTORY="$XDG_DATA_HOME/python/history"
export MYVIMRC="$XDG_CONFIG_HOME/nvim/"
export NEWT_COLORS_FILE="$XDG_CONFIG_HOME/newt-theme.txt"
export DIRENV_SCREENSHOT_DIR="$HOME/.local/scripts/rules/cwd-screenshots"
export BAT_THEME="ansi"
export TYPST_PACKAGE_PATH="$HOME/.typst"
export DEVDIR="$HOME/dev"
