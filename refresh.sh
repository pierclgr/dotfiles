#!/usr/bin/env bash

# if current space is bsp
if [ $(yabai -m query --spaces --space | jq '.type') == '"bsp"' ]
then
    space_info=$(yabai -m query --windows --space | jq)
    number_of_windows=$(yabai -m query --windows --space | jq 'length')

    space_number=$(yabai -m query --windows --window | jq -r '.space')

    num_to_exclude=0

    for row in $(echo "${space_info}" | jq -r '.[] | @base64'); do

        is_visible=$(echo ${row} | base64 --decode | jq -r | jq '."is-visible"')
        is_floating=$(echo ${row} | base64 --decode | jq -r | jq '."is-floating"')
        is_minimized=$(echo ${row} | base64 --decode | jq -r | jq '."is-minimized"')

        if [[ $is_floating == "true" || $is_minimized == "true" || $is_visible == "false" ]]
        then
            num_to_exclude=$(( num_to_exclude + 1 ))
        fi
    done

    number_of_windows=$(( number_of_windows - num_to_exclude ))

    if [ $space_number -le 4 ]
    then
        padding=20

        [ $number_of_windows -le 1 ] && padding=0

        yabai -m config --space $space_number top_padding $padding
        yabai -m config --space $space_number bottom_padding $padding
        yabai -m config --space $space_number left_padding $padding
        yabai -m config --space $space_number right_padding $padding
        yabai -m config --space $space_number window_gap $padding
    fi


else
    # space is float
    # if only 1 window
    if [[ $(yabai -m query --spaces --space | jq '.windows' | jq 'length') == 1 ]]
    then
        # maximize
        skhd -k "ctrl + alt - return"
    fi
fi