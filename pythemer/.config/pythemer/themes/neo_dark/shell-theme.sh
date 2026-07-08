#!/bin/sh
export COLOR_BG="{{ background | shade.01 }}"
export COLOR_AC_BG="{{ shade.03 }}" 
export COLOR_FG="{{ foreground || shade.07 }}"
export COLOR_ACCENT="{{ color12 }}"
export COLOR_BG_OP="{{ background | shade.01 }}99"

export COLOR_ACTIVE_FG="{{ background | shade.01 }}"
export COLOR_ACTIVE_BG="{{ color12 }}"
export COLOR_URGENT_FG="{{ foreground || shade.07 }}"
export COLOR_URGENT_BG="{{ color13 }}99"

export COLOR_MAIN="{{ accent | state.active.accent }}"
export COLOR_RED="{{ red }}"
export COLOR_GREEN="{{ green }}"
export COLOR_YELLOW="{{ yellow }}"
export COLOR_BLUE="{{ blue }}"
export COLOR_MAGENTA="{{ magenta }}"
export COLOR_CYAN="{{ cyan }}"
