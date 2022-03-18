#!/bin/bash

# get input arguments
space=$1
window_id=$2

# if switching to next space
if [ $space == "next" ]
then
    # compute the following space
    next_space=$(yabai -m query --spaces --space | jq '.index')
    next_space=$(( next_space + 1 ))

    # if the computed following space is greater that the last available space
    if [ $next_space -gt $(yabai -m query --spaces | jq '.[-1].index') ]
    then
        # then next space is first space available
        space=1
    else
        # otherwise the next space is the computed one
        space=$next_space
    fi

# if switching to the previous space
elif [ $space == "prev" ]
then
    # compute the previous space
    prev_space=$(yabai -m query --spaces --space | jq '.index')
    prev_space=$(( prev_space - 1 ))
    echo $prev_space 
    # if the computed previous space is smaller than the first available space
    if [ $prev_space -lt $(yabai -m query --spaces | jq '.[0].index') ]
    then
        # then prev space is the last space available
        space=$(yabai -m query --spaces | jq '.[-1].index')
    else
        # otherwise the prev space is the computed one
        space=$prev_space
    fi
fi

# focus target space
yabai -m space --focus $space