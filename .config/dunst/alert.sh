#!/bin/sh 

if [[ $2 == *"$volume_icon $volume"* ]] 
then
    exit
elif [[ $2 == "$brightness" ]]
then
    exit
elif [[ $2 == *"$Playing.."* ]]
then
    exit
fi;

# Play sound here
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
