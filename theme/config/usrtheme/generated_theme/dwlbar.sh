#!/usr/bin/env bash
BG="#3e353799"
FG="#D1DDE3"
ACTIVE_BG="#D1DDE3"
ACTIVE_FG="#3e3537"
URGENT_BG="#3b3838"
URGENT_FG="#D1DDE3"

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
