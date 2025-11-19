# =============================================================================
#  SMART HISTORY & GHOST TEXT (Vim Bindings + Toggle)
# =============================================================================

zmodload zsh/parameter

# --- Configuration ---
typeset -g _smart_search_prefix=""
typeset -g GHOST_TEXT_ENABLED=1  # 1 = On, 0 = Off by default
typeset -g GHOST_COLOR="fg=8"    # 8 is standard grey

# --- GHOST TEXT LOGIC ---

function _update_ghost_text() {
  # Check if enabled and buffer exists
  if [[ "$GHOST_TEXT_ENABLED" -eq 0 || -z "$BUFFER" ]]; then
    POSTDISPLAY=""
    return
  fi

  # Search history (reverse)
  local match="${history[(r)${BUFFER//\//\\/}*]}"

  if [[ -n "$match" && "${#match}" -gt "${#BUFFER}" ]]; then
    local suffix="${match#$BUFFER}"
    POSTDISPLAY="$suffix"
    
    # Apply coloring to the "ghost" area
    region_highlight+=("$#BUFFER $(($#BUFFER + $#suffix)) $GHOST_COLOR")
  else
    POSTDISPLAY=""
  fi
}

function _ghost_toggle() {
  if [[ "$GHOST_TEXT_ENABLED" -eq 1 ]]; then
    GHOST_TEXT_ENABLED=0
    POSTDISPLAY=""
    zle -M "Ghost Text: OFF"
  else
    GHOST_TEXT_ENABLED=1
    zle -M "Ghost Text: ON" # Prints a status message below prompt
  fi
}
zle -N _ghost_toggle

# --- HOOKS ---

# 1. Standard Typing
function _ghost_self_insert() {
  _smart_search_prefix=""
  zle .self-insert
  _update_ghost_text
}
zle -N self-insert _ghost_self_insert

# 2. Tab Completion
function _ghost_tab_handler() {
  _smart_search_prefix=""
  POSTDISPLAY=""          
  zle expand-or-complete  
  _update_ghost_text      
}
zle -N _ghost_tab_handler
bindkey "^I" _ghost_tab_handler 

# 3. Generic Wrapper for all Delete/Kill functions
function _ghost_wrap_widget() {
  local widget=$1
  _smart_search_prefix=""
  zle ".$widget"
  _update_ghost_text
}

# 4. all variants of Delete/Backspace/Kill

# Standard Backspace
function _ghost_backward_delete_char() { _ghost_wrap_widget backward-delete-char }
zle -N backward-delete-char _ghost_backward_delete_char

# Vi Mode Backspace
function _ghost_vi_backward_delete_char() { _ghost_wrap_widget vi-backward-delete-char }
zle -N vi-backward-delete-char _ghost_vi_backward_delete_char

# Standard Delete Key (Del)
function _ghost_delete_char() { _ghost_wrap_widget delete-char }
zle -N delete-char _ghost_delete_char

# Vi Mode Delete Key
function _ghost_vi_delete_char() { _ghost_wrap_widget vi-delete-char }
zle -N vi-delete-char _ghost_vi_delete_char

# Standard Ctrl+W
function _ghost_backward_kill_word() { _ghost_wrap_widget backward-kill-word }
zle -N backward-kill-word _ghost_backward_kill_word

# Vi Mode Ctrl+W
function _ghost_vi_backward_kill_word() { _ghost_wrap_widget vi-backward-kill-word }
zle -N vi-backward-kill-word _ghost_vi_backward_kill_word

# 5. Enter Key
function _ghost_accept_line() {
    _smart_search_prefix=""
    POSTDISPLAY=""
    zle .accept-line
}
zle -N accept-line _ghost_accept_line

# --- SMART HISTORY SEARCH ---

function _smart_history_search_up() {
  # If starting a new search, memorize the current input
  if [[ -z "$_smart_search_prefix" ]]; then
    if [[ -n "$BUFFER" ]]; then
       _smart_search_prefix="$LBUFFER"
    else
       zle up-history
       return
    fi
  fi

  # Snap cursor back to the prefix position so Zsh searches correctly
  CURSOR=${#_smart_search_prefix}
  
  POSTDISPLAY="" 
  if zle history-beginning-search-backward; then
  else
    # If search fails, ensure cursor is still at end
    zle end-of-line
  fi
}
zle -N _smart_history_search_up

function _smart_history_search_down() {
   # If no search is active, standard behavior
   if [[ -z "$_smart_search_prefix" ]]; then
     zle down-history
     return
   fi

   # Snap cursor back to prefix position
   CURSOR=${#_smart_search_prefix}
   
   POSTDISPLAY=""
   # Perform Search
   if zle history-beginning-search-forward; then
     # If we returned to the original text, clear the state
     if [[ "$BUFFER" == "$_smart_search_prefix" ]]; then
         _smart_search_prefix=""
     fi
     zle end-of-line
   else
     zle end-of-line
   fi
}
zle -N _smart_history_search_down

# --- KEY BINDINGS ---

# Vim-like History Search
bindkey "^K" _smart_history_search_up    # Ctrl + k 
bindkey "^J" _smart_history_search_down  # Ctrl + j

# Toggle Ghost Text
bindkey "^G" _ghost_toggle               # Ctrl + g
