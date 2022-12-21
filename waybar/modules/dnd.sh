#!/bin/sh
if [[ "$1" == "exec" ]]
then
    alt=$(makoctl mode | grep -q 'do-not-disturb' &&
           echo dnd || echo default)
    mode=$(makoctl mode | tail -1)

    printf '{\"alt\":\"%s\",\"tooltip\":\"mode: %s\"}'
        "$alt" "$mode"
fi

if [[ "$1" == "click" ]]
then
    makoctl mode | grep 'do-not-disturb' &&
    makoctl mode -r do-not-disturb ||
    makoctl mode -a do-not-disturb;
    pkill -RTMIN+11 waybar
fi

if [[ "$1" == "restore" ]]
then
    makoctl restore
fi
