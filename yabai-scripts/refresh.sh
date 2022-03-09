#!/usr/bin/env bash

# if current space is bsp
if [ $(yabai -m query --spaces --space | jq '.type') == '"bsp"' ]
then
    # get the informations of the current space
    space_info=$(yabai -m query --windows --space | jq)

    # get the number of windows in the current space
    number_of_windows=$(yabai -m query --windows --space | jq 'length')

    # get current space number
    space_number=$(yabai -m query --windows --window | jq -r '.space')

    # get the number of connected displays
    num_displays=$(yabai -m query --displays | jq 'length')

    # count the number of floating, minimized or hidden windows to exclude from the 
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

    # compute final number of windows to consider in the smart border
    number_of_windows=$(( number_of_windows - num_to_exclude ))
    
    # get current display id
    current_display=$(yabai -m query --windows --window | jq -r '.display')

    # if the total number of displays is more than 1
    if [ $num_displays -ge 2 ]
    then
        # multiple displays are connected, so main is 1 and is the big one

        # if current display is number one
        if [ $current_display == 1 ] 
        then
            # then it is the big one, so set padding to 40
            padding=35
        else
            # otherwise it is the laptop one, so set padding to 20
            padding=20
        fi 
    else
        # one display connected so it is the laptop one and the padding is 20
        padding=20
    fi

    # if the current space has no valid windows (managed by yabai and visible), then set the padding to 0
    [ $number_of_windows -le 1 ] && padding=0

    # set padding values for the current space
    yabai -m config --space $space_number top_padding $padding
    yabai -m config --space $space_number bottom_padding $padding
    yabai -m config --space $space_number left_padding $padding
    yabai -m config --space $space_number right_padding $padding
    yabai -m config --space $space_number window_gap $padding

else
    # space is float
    # if only 1 window
    if [[ $(yabai -m query --spaces --space | jq '.windows' | jq 'length') == 1 ]]
    then
        # maximize
        skhd -k "ctrl + alt - return"
    fi
fi