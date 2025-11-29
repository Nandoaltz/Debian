#!/bin/bash

intervalo=0.5

while true; do
    status=$(playerctl --player=spotify status 2>/dev/null)

    if [ -z "$status" ] || [ "$status" == "No players found" ]; then
        echo "󰪏" 
        sleep 5
        exit 0
    fi

    max_length=9

    if [ "$status" == "Playing" ] || [ "$status" == "Paused" ]; then
       
        text=$(playerctl --player=spotify metadata --format "{{ artist }} - {{ title }}" 2>/dev/null)
        
        if [ "$status" == "Playing" ]; then
            play_icon="󰏤"  
        elif [ "$status" == "Paused" ]; then
            play_icon="󰐊" 
        fi
    fi

    if [ ${#text} -gt $max_length ]; then
        text="${text:0:$((max_length - 3))}..."  
    fi

    echo "%{A:playerctl --player=spotify previous:}󰒮%{A} %{A:playerctl --player=spotify play-pause:}$play_icon%{A} %{A:playerctl --player=spotify next:}󰒭%{A} $text"

    sleep $intervalo
done
