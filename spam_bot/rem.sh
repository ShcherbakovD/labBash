#!/bin/bash
echo "Введите название директорий";
read directory;
echo "Введите число директорий";
read d;
clear;
for ((i=1;i<=d;i++))
do
rm -r $directory$i;

done
echo "Готово))";
