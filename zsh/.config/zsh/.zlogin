BAT_LEVEL="$(cat /sys/class/power_supply/BAT0/capacity)"

echo "... login success!"
echo "Welcome $USER"

/home/aidanfleming/.config/zsh/login-splash
echo ""

if (( BAT_LEVEL < 40 )); then
    echo "Battery $BAT_LEVEL% - Warning: Battery is low!"
elif (( BAT_LEVEL < 10 )); then
    echo "Battery $BAT_LEVEL% - Warning: Battery is very low! Find an Outlet!"

elif (( BAT_LEVEL < 5 )); then
    echo "Battery $BAT_LEVEL% - Warning: Battery is empty!"
else
    echo "Battery $BAT_LEVEL% - Battery level is good."
fi

echo ""
echo "---- zsh ----"
