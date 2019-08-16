#!/bin/bash

blickLight=$1;
lightCaps=$2;
lightNum=$3;

for (( i=1; i <= blickLight; i++ ))

do

xdotool key Caps_Lock
sleep $lightCaps;

xdotool key Num_Lock
sleep $lightNum;

xdotool key Caps_Lock
sleep $lightCaps;

xdotool key Num_Lock
sleep $lightNum;

done
