# XDG conventions
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# bootstrap zsh config files
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

MYLIB="$HOME/lib"
export TYPST_PACKAGE_PATH="$MYLIB/typst"
export GOPATH="$XDG_DATA_HOME/go"
export PYTHONPATH="$HOME/.local/share/python/lib:$PYTHONPATH"
export LUA_PATH="$LUA_PATH;$XDG_DATA_HOME/lua/share/lua/5.4/?.lua"
export LUA_PATH="$LUA_PATH;$XDG_DATA_HOME/lua/share/lua/5.4/?/init.lua"
export LUA_CPATH="$LUA_CPATH;$XDG_DATA_HOME/lua/lib/lua/5.4/?.so"

# Path management
# typeset -U no duplicate entries
typeset -U path PATH
path=(
    "$HOME/.local/bin"
    "$HOME/bin/nvim/bin"
    "$HOME/.cargo/bin"
	"$HOME/.spicetify"
	"$GOPATH"
    $path
)
export PATH
