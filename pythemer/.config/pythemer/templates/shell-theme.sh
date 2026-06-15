#!/bin/sh
export COLOR_BG="{{ background | shade.01 }}"
export COLOR_AC_BG="{{state.active_background | shade.03}}" 
export COLOR_FG="{{ foreground || shade.07 }}"
export COLOR_ACCENT="{{ color12 }}"
export COLOR_BG_OP="{{ background | shade.01 }}99"

export COLOR_ACTIVE_FG="{{ background | shade.01 }}"
export COLOR_ACTIVE_BG="{{ color12 }}"
export COLOR_URGENT_FG="{{ foreground || shade.07 }}"
export COLOR_URGENT_BG="{{ color13 }}99"

export COLOR_MAIN="{{ accent | state.active.accent }}"
export COLOR_RED="{{ red | named.red | color1 }}"
export COLOR_GREEN="{{ green | named.green | color2 }}"
export COLOR_YELLOW="{{ yellow | named.yellow | color3 }}"
export COLOR_BLUE="{{ blue | named.blue | color4 }}"
export COLOR_MAGENTA="{{ magenta | named.magenta | color5 }}"
export COLOR_CYAN="{{ cyan | named.cyan | color6 }}"
