#!/bin/bash
echo "Введите путь к каталогу";
read add;
cd $add;
echo "Шаблон названия директорий";
read directory;
echo "Введите число директорий";
read d;
echo "Шаблон названия поддиректорий";
read postDirectory;
echo "Введите число поддиректорий";
read pD;
echo "Шаблон названия файлов";
read file;
echo "Введите число файлов";
read f;
clear;
for (( i=1; i<=d; i++ ))
    do
        sudo mkdir $directory$i;
sudo chmod 777 $directory$i;
cd $directory$i;
for (( j=1; j<=pD; j++ ))
    do
        sudo mkdir $postDirectory$j;
sudo chmod 777 $postDirectory$j;
cd $postDirectory$j;
for (( g=1; g<=f; g++ ))
    do
        touch $file$g;
done
cd ../;
echo "Готов $postDirectory$j";
done
cd ../;
echo "Готов $directory$i";
done
echo "Шалость удалась))";
