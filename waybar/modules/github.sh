if [[ "$1" == "exec-if" ]]
then
    [ -x "$(command -v gh)" ] &&
    (gh auth status 2>&1 | grep -q -m 1 'Logged in') &&
    (gh api '/notifications' -q 'length' | grep -q -m 1 '0') &&
    exit 0
elif [[ "$1" == "exec" ]]; then
    gh api '/notifications' -q '{ text: length }' | cat -
elif [[ "$1" == "on-click" ]]; then
    xdg-open https://github.com/notifications &&
    sleep 30 &&
    pkill -RTMIN+4 waybar
else
    exit 1
fi
