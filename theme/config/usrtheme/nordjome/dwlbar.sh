#!/usr/bin/env bash
BG="#35252a"
FG="#E1DFED"
ACTIVE_BG="#E1DFED"
ACTIVE_FG="#35252a"
URGENT_BG="#3a3737"
URGENT_FG="#E1DFED"

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
	-font """$USR_FONT_MONO"":size=14"; sleep 0.2) &

aslstatus -s \
    | dwlb -status-stdin all &
    # | sed -u "s/${ASL_HARDCODED_COLOR}/${ACTIVE_FG}/g" \
