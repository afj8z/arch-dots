#!/bin/sh
export COLOR_BG="{{ background | shade.01 }}"
export COLOR_FG="{{ foreground || shade.07 }}"
export COLOR_ACCENT="{{ color12 }}"
export COLOR_BG_OP="{{ background | shade.01 }}99"

export COLOR_ACTIVE_FG="{{ background | shade.01 }}"
export COLOR_ACTIVE_BG="{{ color12 }}"
export COLOR_URGENT_FG="{{ foreground || shade.07 }}"
export COLOR_URGENT_BG="{{ color13 }}99"
