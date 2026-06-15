#!/usr/bin/env bash
BG="#383836"
FG="#EDEDDA"
ACTIVE_BG="#B48EAD"
ACTIVE_FG="#383836"
URGENT_BG="#D18498"
URGENT_FG="#EDEDDA"

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
    -middle-bg-color-selected "$ACTIVE_BG"; sleep 0.2) &

aslstatus -s \
    | sed -u "s/${ASL_HARDCODED_COLOR}/${ACTIVE_FG}/g" \
    | dwlb -status-stdin all &
