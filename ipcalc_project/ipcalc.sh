#!/bin/bash

ip=$1; mask=$2

IFS=. read -r i1 i2 i3 i4 <<< "$ip"
IFS=. read -r m1 m2 m3 m4 <<< "$mask"

echo -e "\e[32mDefaultVersion\e[0m";
echo "1)IP-addres : $ip"

echo "2)Mask      : $mask"
mask=$(for i in $(echo ${mask} | tr '.' ' '); do echo "obase=2 ; $i" | bc; done| awk '{printf ".%08d", $mask}' | cut -c2-);
wildCard=$((255-$m1)).$((255-$m2)).$((255-$m3)).$((255-$m4));
echo "3)Wildcard  : $wildCard"

network=$((i1 & m1)).$((i2 & m2)).$((i3 & m3)).$((i4 & m4))
echo "4)Network   : $network"

minHost=$((i1 & m1)).$((i2 & m2)).$((i3 & m3)).$(((i4 & m4)+1))
echo "5)Min Host  : $minHost"

maxHost=$((i1 & m1 | 255-m1)).$((i2 & m2 | 255-m2)).$((i3 & m3 | 255-m3)).$(((i4 & m4 | 255-m4)-1))
echo "6)Max Host  : $maxHost"
broadCast=$((i1 & m1 | 255-m1)).$((i2 & m2 | 255-m2)).$((i3 & m3 | 255-m3)).$((i4 & m4 | 255-m4));
echo "7)Broadcast : $broadCast"
i=0; hosts=1;
numderZero=$(echo $mask | grep -o "[0]"|wc -l)
while [[  $i -ne $numderZero ]];do 
hosts=$(($hosts*2));i=$(($i+1)); 
done
hosts=$(($hosts-2));
echo "8)Hosts     : $hosts";
echo "###############################################################";
echo -e "\e[31mBitVersion\e[0m";
echo -n "1)IP-addres : "
for i in $(echo ${ip} | tr '.' ' '); do echo "obase=2 ; $i" | bc; done| awk '{printf ".%08d", $1}' | cut -c2-
echo  "2)Mask      : $mask"
echo -n "3)Wildcard  : "
for i in $(echo ${wildCard} | tr '.' ' '); do echo "obase=2 ; $i" | bc; done| awk '{printf ".%08d", $wildCard}' | cut -c2-
echo -n "4)Network   : "
for i in $(echo ${network} | tr '.' ' '); do echo "obase=2 ; $i" | bc; done| awk '{printf ".%08d", $network}' | cut -c2-
echo -n "5)Min Host  : "
for i in $(echo ${minHost} | tr '.' ' '); do echo "obase=2 ; $i" | bc; done| awk '{printf ".%08d", $minHost}' | cut -c2-
echo -n "6)Max Host  : "
for i in $(echo ${maxHost} | tr '.' ' '); do echo "obase=2 ; $i" | bc; done| awk '{printf ".%08d", $maxHost}' | cut -c2-
echo -n "7)Broadcast : "
for i in $(echo ${broadCast} | tr '.' ' '); do echo "obase=2 ; $i" | bc; done| awk '{printf ".%08d", $broadCast}' | cut -c2-
echo -n "8)Hosts     : ";
classOfHost=$(for i in $(echo ${network} | cut -d '.' -f1); do echo "obase=2 ; $i" | bc; done| awk '{printf ".%08d", $network}' | cut -c2-);
if [[ ${classOfHost:0:1} -eq 0 ]]; then echo "A-class";
fi
if [[ ${classOfHost:0:2} -eq 10 ]]; then echo "B-class";
fi
if [[ ${classOfHost:0:3} -eq 110 ]]; then echo "C-class";
fi
if [[ ${classOfHost:0:4} -eq 1110 ]]; then echo "D-class";
fi
if [[ ${classOfHost:0:4} -eq 1111 ]]; then echo "E-class";
fi
