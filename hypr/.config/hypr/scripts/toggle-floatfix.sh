# get the class and floating status of the active window
is_floating=$(hyprctl activewindow | awk -F": " '/floating:/ {print $2}')

# if the window is already floating, toggle it back to tiled
if [[ $is_floating == "1" ]]; then
    hyprctl dispatch togglefloating
    exit 0
  else
    hyprctl dispatch togglefloating
 	hyprctl dispatch resizeactive exact 60% 60%
 	hyprctl dispatch centerwindow
fi

# active_class=$(hyprctl activewindow | awk -F": " '/class:/ {print $2}')
# if [[ $active_class == *"firefox"* ]]; then
#     hyprctl dispatch togglefloating
# 	hyprctl dispatch resizeactive exact 50% 50%
# 	hyprctl dispatch centerwindow
# else
#     hyprctl dispatch togglefloating
# fi
