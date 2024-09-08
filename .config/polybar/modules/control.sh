#!/usr/bin/env bash


# Function to get player status
get_status() {
    status=$(playerctl status 2> /dev/null)
    if [[ $status == "Playing" ]]; then
        echo ""
    elif [[ $status == "Paused" ]]; then
        echo ""
    else
        echo ""
    fi
}

# Function to get truncated metadata (you can change the word count in the awk section)
get_metadata() {
    metadata=$(playerctl metadata --format "{{ artist }} - {{ title }}" 2> /dev/null)
    echo "${metadata:0:50}" | awk '{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10}'
}

# Main logic
case $1 in
    --toggle)
        playerctl play-pause
        ;;
    --next)
        playerctl next
        ;;
    --previous)
        playerctl previous
        ;;
    --seek-forward)
        playerctl position 5+
        ;;
    --seek-backward)
        playerctl position 5-
        ;;
    --toggle-random)
        playerctl shuffle toggle
        ;;
    --toggle-repeat)
        playerctl loop
        ;;
    *)
        echo "$(get_status) $(get_metadata) %{A1:$0 --toggle:}%{A} %{A1:$0 --previous:}%{A} %{A1:$0 --seek-backward:}%{A} %{A1:$0 --seek-forward:}%{A} %{A1:$0 --next:}%{A} %{A1:$0 --toggle-random:}%{A} %{A1:$0 --toggle-repeat:}%{A}"
        ;;
esac