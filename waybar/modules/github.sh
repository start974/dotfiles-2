case $1 in
'exec-if')
    [ -x "$(command -v gh)" ] &&
    (gh auth status 2>&1 | grep -q -m 1 'Logged in') &&
    (gh api '/notifications' -q 'length' | grep -q -m 1 '0') ||
    exit 1
    ;;

'exec')
    gh api '/notifications' -q '{ text: length }' | cat -
    ;;

'on-click')
    xdg-open https://github.com/notifications &&
    sleep 30 &&
    pkill -RTMIN+4 waybar
    ;;
*)
    exit 1
    ;;
esac
