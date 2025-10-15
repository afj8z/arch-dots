#!/bin/bash


# --- CONFIGURATION ---
TITLE_COLOR="#90a0b5"
LOGO_COLOR="#90a0b5"
WARN_COLOR="#c4746e"
VALUE_COLOR="#cfcbbe"
BG_COLOR="#1A1718"
# --- ASCII ART LOGO ---
ARCH_LOGO=(
"        .        "
"       / \       "
"      /   \      "
"     /^.   \     "
"    /  .-.  \    "
"   /  (   ) _\   "
"  / _.~   ~._^\  "
" /.^         ^.\ "

  ) 

# --- HELPER FUNCTIONS ---
create_line() {
    local title="$1"
    local value="$2"
    echo "<b><span color='${TITLE_COLOR}'>${title}:</span></b> <span color='${VALUE_COLOR}'>${value}</span>"
}

color_logo() {
  local sym="$1"
  echo "<b><span color='${LOGO_COLOR}'>${sym}</span></b>"
}

header_line() {
  local title="$1"
  echo "<b><span color='${VALUE_COLOR}'>${title}</span></b>"
}

separator_line() {
  local title="$1"
  echo "<span color='${VALUE_COLOR}'>${title}</span>"
}

author_line() {
  local prompt="$1"
  local title="$2"
  echo "<span color='${VALUE_COLOR}'>${prompt}<i>    ${title}</i></span>"
}

quote_line (){
  local title="$1"
  echo "<span color='${VALUE_COLOR}'>${title}</span>"
}

print_with_bg() {
    local line_content="$1"
    local max_width="$2"

    # Use a non-greedy perl command to accurately measure visible text
    local plain_text=$(echo -e "$line_content" | perl -pe 's/<.*?>//g')
    local current_width=${#plain_text}

    local padding_needed=$((max_width - current_width))
    local padding=""

    if (( padding_needed > 0 )); then
        padding=$(printf '%*s' "$padding_needed" '')
    fi

    # UPDATED: Added a space before and after the content+padding
    echo "<span background='${BG_COLOR}'> ${line_content}${padding} </span>"
}

# --- GATHER SYSTEM DATA ---
USER_VAL="$USER@$HOSTNAME"
SEPERATER="---"
OS_VAL=$(hostnamectl | grep "Operating System" | cut -d ':' -f 2 | sed 's/^[ \t]*//')
KERNEL_VAL=$(uname -r)
CPU_VAL=$(lscpu | grep "Model name:" | sed 's/Model name:[ \t]*//')
MEM_VAL=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')

CONTENT_USER=$(header_line "$USER_VAL")
CONTENT_OS=$(create_line "OS" "$OS_VAL")
CONTENT_KERNEL=$(create_line "Kernel" "$KERNEL_VAL")
CONTENT_CPU=$(create_line "CPU" "$CPU_VAL")
CONTENT_MEM=$(create_line "Mem" "$MEM_VAL")
CONTENT_BATTERY=""
CONTENT_NETWORK=""

if [ -d /sys/class/power_supply/BAT1 ]; then
    CAPACITY=$(cat /sys/class/power_supply/BAT1/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT1/status)
    [ "$STATUS" = "Charging" ]
    BATTERY_VAL="$CAPACITY%"
    CONTENT_BATTERY=$(create_line "Battery" "$BATTERY_VAL")
fi

if command -v nmcli &> /dev/null; then
    ACTIVE_CONN=$(nmcli -t -f NAME,DEVICE,TYPE c show --active | head -n 1)
    if [ -n "$ACTIVE_CONN" ]; then
        CONN_NAME=$(echo "$ACTIVE_CONN" | cut -d':' -f1)
        CONN_TYPE=$(echo "$ACTIVE_CONN" | cut -d':' -f3)
        ICON=""
        [[ "$CONN_TYPE" == "802-11-wireless" ]] && ICON="wifi "
        [[ "$CONN_TYPE" == "802-3-ethernet" ]] && ICON="eth "
        NETWORK_VAL="$ICON$CONN_NAME"
        CONTENT_NETWORK=$(create_line "Network" "$NETWORK_VAL")
    fi
fi

SYS_TEXT=(
"$CONTENT_USER"
"$SEPERATER"
"$CONTENT_OS"
"$CONTENT_KERNEL"
"$CONTENT_CPU"
"$CONTENT_MEM"
"$CONTENT_BATTERY"
"$CONTENT_NETWORK"
)

# --- BUILD AND PRINT FINAL OUTPUT ---

# Master array to hold ALL lines of output
declare -a ALL_LINES

# 1. Add the logo and system info lines
for i in "${!ARCH_LOGO[@]}"; do
    line="$(color_logo "${ARCH_LOGO[$i]}") ${SYS_TEXT[$i]}"
    ALL_LINES+=("$line")
done

# 2. Prepare all the local info and quote lines
current_date=$(date +"%A, %d %B %Y")
current_time=$(date +"%H:%M %Z")
clients=($(hyprctl clients | awk '/class: / {print $2}'))
count=${#clients[@]}

if (( count > 4 )); then
    n=$((count - 4))
    first_four="${clients[@]:0:4}"
    open_clients="${first_four// /, } (+$n)"
else
    all_clients="${clients[@]}"
    open_clients="${all_clients// /, }"
fi

random_quote=$("$HOME/.local/scripts/random_quote.sh")
if [ -n "$random_quote" ]; then
    IFS='|' read -r quote author <<< "$random_quote"
fi

# 3. Add a PLACEHOLDER for the separator and then add the rest of the lines
ALL_LINES+=("__SEPARATOR__")
ALL_LINES+=("$(create_line "Date" "$current_date")")
ALL_LINES+=("$(create_line "Time" "$current_time")")
ALL_LINES+=("$(create_line "Clients" "$open_clients")")
ALL_LINES+=("$(separator_line "")")
ALL_LINES+=("$(separator_line "<span color='${WARN_COLOR}'> Screen locked</span> >>> type password ")")
ALL_LINES+=("$(separator_line "")")

# 4. Add the formatted quote lines to the master array
if [ -n "$random_quote" ]; then
    mapfile -t formatted_quote_lines < <(echo "$quote" | fmt -w 50 | sed 's/^/> /')
    for q_line in "${formatted_quote_lines[@]}"; do
        ALL_LINES+=("$(quote_line "$q_line")")
    done
    ALL_LINES+=("$(author_line "" "— $author")")
fi

# 5. Calculate the TRUE max width from ALL generated lines (except the placeholder)
max_width=0
for line in "${ALL_LINES[@]}"; do
    # Skip the placeholder for measurement
    if [[ "$line" == "__SEPARATOR__" ]]; then continue; fi

    # Use a non-greedy perl command to correctly strip tags
    plain_text=$(echo -e "$line" | perl -pe 's/<.*?>//g')
    current_width=${#plain_text}
    if (( current_width > max_width )); then
        max_width=$current_width
    fi
done

# 6. Now that we have the final max_width, create the real separator
separator_dashes=$(printf '%*s' "$max_width" '' | tr ' ' '-')
final_separator_line=$(separator_line "$separator_dashes")

# 7. Replace the placeholder with the correctly sized separator
for i in "${!ALL_LINES[@]}"; do
    if [[ "${ALL_LINES[$i]}" == "__SEPARATOR__" ]]; then
        ALL_LINES[$i]="$final_separator_line"
        break
    fi
done

total_width=$((max_width + 2))
blank_line_content=$(printf '%*s' "$total_width" '')
blank_line="<span background='${BG_COLOR}'>${blank_line_content}</span>"

# 7. Print the final, fully padded output
echo "$blank_line"

for line in "${ALL_LINES[@]}"; do
    print_with_bg "$line" "$max_width"
done

echo "$blank_line"
