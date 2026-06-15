# Base Defaults
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="foot"
export BROWSER="firefox"
export PAGER="/bin/less"
export MANPAGER="nvim +Man!"

# Custom Defaults
export MYLIB="$HOME/lib"
export DEVDIR="$HOME/dev"
export USR_FONT_MONO="JomeNFMono-Regular"
export USR_FONT_SERIF="Bitter"

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Tool-Specific
export QUILT_PATCHES=patches
export QUILT_REFRESH_ARGS="-p ab --no-timestamps --no-index"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export PYTHON_HISTORY="$XDG_DATA_HOME/python/history"
export MYVIMRC="$XDG_CONFIG_HOME/nvim/init.lua"
export NEWT_COLORS_FILE="$XDG_CONFIG_HOME/newt-theme.txt"
export NVM_DIR="$HOME/.config/nvm"
export BAT_THEME="ansi"
export LUAROCKS_CONFIG="$HOME/.config/lua/luarocks-5.4.lua"
export R_PROFILE_USER="$HOME/.config/R/.Rprofile"
export R_ENVIRON_USER="$HOME/.config/R/.Renviron"

# Wayland stuff
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM="wayland"
export _JAVA_AWT_WM_NONREPARENTING=1
