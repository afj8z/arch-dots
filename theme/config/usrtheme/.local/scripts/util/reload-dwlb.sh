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

# Dynamic Sed Command Generator
THEME_SED_CMD=""
SORTED_VARS=$(env | grep "^COLOR_" | cut -d= -f1 | awk '{ print length, $0 }' | sort -nr | cut -d" " -f2-)
for var in $SORTED_VARS; do
    eval val=\$$var
    clean_val=$(echo "$val" | tr -d '[:space:]')
    THEME_SED_CMD="${THEME_SED_CMD}s|${var}|${clean_val}|g;"
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
    -font """$USR_FONT_MONO"":size=15"; sleep 0.05) >/dev/null 2>&1 &
# Ensure ASL_HARDCODED_COLOR == hardcoded value in aslstatus/config.h
aslstatus -s \
    | sed -u "${THEME_SED_CMD}s|${ASL_HARDCODED_COLOR:-#FF00FF}|${ACTIVE_FG}|g;s|BATFG|#E9F25A|g" \
    | dwlb -status-stdin all >/dev/null 2>&1 &
