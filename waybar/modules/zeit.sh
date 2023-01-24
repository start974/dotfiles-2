#!/bin/sh
tracking=$(zeit tracking --no-colors)

case $1 in
'exec-if')
    [ -x "$(command -v zeit)" ] ||
    exit 1
    ;;

'status')
    text=$(echo -n $tracking | grep -q 'tracking' &&
        echo "tracking" || echo "stopped")
    tooltip=$tracking'\r(zeit time tracker)'
    echo {\"text\":\"$text\"\,\"tooltip\":\"$tooltip\"\,\"class\":\"$text\"\,\"alt\":\"$text\"}
    ;;

'on-click')
  if echo "$tracking" | grep -q 'tracking'
  then
    zeit finish
  else
    swaymsg exec \$zeit_list
  fi
  pkill -RTMIN+10 waybar
    ;;

'track')
    input=$(cat -)
    task=$(echo "$input" | pcregrep -io1 '└── (.+) \[.+')
    project=$(echo "$input" | pcregrep -io1 '.+\[(.+)\]')

    if [[ "$task" == "" ]] || [[ "$project" == "" ]]
    then
        notify-send "You did not select a task!"
        exit 1
    fi

    zeit track -p "$project" -t "$task"
    notify-send "Tracking $task in $project"
    ;;
*)
    exit 1
    ;;
esac

