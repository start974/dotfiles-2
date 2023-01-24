
case $1 in
'exec-if')
    ([ -x "$(command -v cliphist)" ] &&
        [ $(cliphist list | wc -l) -gt 0 ] )||
    exit 1
    ;;

'exec')
    printf '{\"tooltip\":\"%s\"}' $(cliphist list | wc -l) \
        'item(s) in the clipboard\r(Mid click to clear)'
    ;;

'on-click')
    swaymsg -q exec '$clipboard';
    pkill -RTMIN+9 waybar
    ;;

'on-click-right')
    swaymsg -q exec '$clipboard-del';
    pkill -RTMIN+9 waybar
    ;;

'on-click-middle')
    rm -f ~/.cache/cliphist/db;
    pkill -RTMIN+9 waybar
    ;;
*)
    exit 1
    ;;
esac
