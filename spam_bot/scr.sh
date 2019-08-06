#!/bin/bash
echo "Введите путь к каталогу"; 
read add;
cd $add;
echo "Шаблон названия директорий"; 
read catalog;
echo "Введите число директорий"; 
read d;
echo "Шаблон названия файлов"; 
read file;
echo "Введите число файлов";
read f;
clear;
for ((i=0;i<d;i++)) 
do 
sudo mkdir $catalog$i;
sudo chmod 777 $catalog$i;
cd $catalog$i;
for ((j=0;j<f;j++)) 
do
touch $file$j;
done
cd ../;
echo "Готов $catalog$i";
done 
echo "Готово))";
