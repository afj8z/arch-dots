#!/usr/bin/env bash
BG="{{ state.active_background | shade.03 }}99"
FG="{{ foreground || shade.07 }}"
ACTIVE_BG="{{ state.active_foreground | color5 }}"
ACTIVE_FG="{{ state.active_background | shade.03 }}"
URGENT_BG="{{ urgency.high_background | color13 }}"
URGENT_FG="{{ urgency.high_foreground | foreground || shade.07 }}"

_ps="dwlb aslstatus"
for _prs in $_ps; do
    if pidof "${_prs}" >/dev/null; then
         killall -9 "${_prs}"
    fi
done

(dwlb -ipc -scale 2 \
    -active-fg-color "$ACTIVE_FG" \
    -active-bg-color "$ACTIVE_BG" \
    -occupied-fg-color "$FG" \
    -occupied-bg-color "$BG" \
    -inactive-fg-color "$FG" \
    -inactive-bg-color "$BG" \
    -urgent-fg-color "$URGENT_FG" \
    -urgent-bg-color "$URGENT_BG" \
    -middle-bg-color "$BG" \
    -middle-bg-color-selected "$BG"\
	-font """$USR_FONT_MONO"":size=15"; sleep 0.2) &

aslstatus -s \
    | sed -u "s/${ASL_HARDCODED_COLOR}/${ACTIVE_FG}/g" \
    | dwlb -status-stdin all &
