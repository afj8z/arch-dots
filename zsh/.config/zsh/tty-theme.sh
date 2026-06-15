#!/usr/bin/env bash
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P01D1F21" #black
    echo -en "\e]P8454A4F" #darkgrey
    echo -en "\e]P1C46767" #darkred
    echo -en "\e]P9E09696" #red
    echo -en "\e]P286A672" #darkgreen
    echo -en "\e]PAAFCF9B" #green
    echo -en "\e]P3C2A36B" #brown
    echo -en "\e]PBE3C78B" #yellow
    echo -en "\e]P46B8EAD" #darkblue
    echo -en "\e]PC93B5D1" #blue
    echo -en "\e]P5A375A3" #darkmagenta
    echo -en "\e]PDC9A2C9" #magenta
    echo -en "\e]P66BA39C" #darkcyan
    echo -en "\e]PE94CDC5" #cyan
    echo -en "\e]P799978F" #lightgrey
    echo -en "\e]PFDEDCD3" #white
    clear #for background artifacting
fi
