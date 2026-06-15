#!/usr/bin/env bash

tmux list-sessions -F "#{session_name}:#{?session_attached,1,0}" | awk -F: '
{
    # DATA
    names[NR] = $1
    status[NR] = $2
    if ($2 == "1") active_idx = NR
}

END {
    total = NR
    printed_any = 0

    # show 1 before and 1 after
    start_i = active_idx - 1
    end_i = active_idx + 1

    # if active is #1, show active + 2 
    if (active_idx == 1) {
        start_i = 1
        end_i = 3
    }

    # if active is last, show active - 2
    if (active_idx == total) {
        start_i = total - 2
        end_i = total
    }

    if (start_i < 1) start_i = 1
    if (end_i > total) end_i = total

    # if 3 or less total sessions, ignore window and show all
    if (total <= 3) {
        start_i = 1
        end_i = total
    }

    # LOOP
    for (i = 1; i <= total; i++) {
        
        if (i >= start_i && i <= end_i) {
            
			# this keeps indexes in same position when switching, 
			# accounting for missing border separator
            if (printed_any == 0) {
                if (active_idx > 1) {
                    printf ""
                } 
            } else {
                printf " "
            }

            if (status[i] == "1") {
                # active: [Index*Name]
                printf "#[bg=colour0,fg=#{@ACCENTCLR},bold]" i "*" names[i] "#[default]"
            } else {

                printf "#[fg=colour8]" i " " names[i] "#[default]"
			
            }

            printed_any = 1
        }
    }

    if (total > 3) {
        printf " #[fg=colour8][" total "]#[default]"
    }
}'
