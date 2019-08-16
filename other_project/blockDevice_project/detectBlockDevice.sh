#!/bin/bash

errorInWay=3;
while [[ $errorInWay -eq 3 ]];
do
read wayIfBackUp;
clear;
flagOfDd=0;
errorInWay=0;
if  ! test -f $wayIfBackUp;
then errorInWay=$(($errorInWay+1));
fi
if  ! test -d $wayIfBackUp;
then errorInWay=$(($errorInWay+1));
fi
if  test -b $wayIfBackUp;
then
flagOfDd=$(($flagOfDd+1));
else
    errorInWay=$(($errorInWay+1));
fi
if (($errorInWay==3));
then
echo "Повторите операцию ввода";
fi
done
echo "Найден путь $wayIfBackUp";
