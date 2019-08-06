#!/bin/bash

checkWay () {
    errorInWay=3;
    while [[ $errorInWay -eq 3 ]];
    do
    echo -n "Введите wayIfBackUp : " ; read wayIfBackUp;
    flagOfDd=0; errorInWay=0;
    if  ! test -f $wayIfBackUp;
then
errorInWay=$(($errorInWay+1));
    fi
    if  ! test -d $wayIfBackUp;
then
errorInWay=$(($errorInWay+1));
    fi
    if  test -b $wayIfBackUp;
then
flagOfDd=$(($flagOfDd+1));
    else
        errorInWay=$(($errorInWay+1));
    fi
    echo $flagOfDd;
    if (($errorInWay==3));
    then
    echo "Повторите операцию ввода";
    fi
    done
clear;

    errorInWay=3;
    while [[ $errorInWay -eq 3 ]];
    do
    echo -n "Введите wayOfBackUp : "; read wayOfBackUp;
	errorInWay=0;
    if  ! test -f $wayOfBackUp;
then
errorInWay=$(($errorInWay+1));
    fi
    if  ! test -d $wayOfBackUp;
then
errorInWay=$(($errorInWay+1));
    fi
    if  test -b $wayOfBackUp;
then
flagOfDd=$(($flagOfDd+1));
    else
        errorInWay=$(($errorInWay+1));
    fi
    echo $flagOfDd
    if (($errorInWay==3));
    then
    echo "Повторите операцию ввода";
    fi
    done
clear;
}

setOperation() {
    checkWay;
    setTimes;
    clear;
    setDays;
    clear;
    if [ $flagOfDd -gt 0 ];
    then
    crontab -l | { cat; echo "$min $hour $dayOfMonth $month * dd if=$wayIfBackUp of=$wayOfBackUp/backup.iso "; } | crontab -
    else
        crontab -l | { cat; echo "$min $hour $dayOfMonth $month * -czf $wayOfBackUp/backup.tgz $wayIfBackUp"; } | crontab -
        fi
    }
setTimes() {
    echo -e "Введите время срабатывания (через пробел!!!) Час Минута";
    while [[ True ]];
    do
        read hour min
        if [[ $hour -gt 23 || $month -lt 0 || $min -gt 59 || $min -lt 0 ]];
    then
    echo "Error : Введены некорректные данные";
    echo "Введите корректные данные";
    else
        break
        fi
        done
    }
setDays() {
    echo -e "Введите время срабатывания (через пробел!!!) День Месяц";
    echo -e "0 в указании Дня/Месяца = ежедневное/ежемесячное включение ";
    while [[ True ]];
    do
        read dayOfMonth month
        if [[ $dayOfMonth -eq 0 ]];
    then
    dayOfMonth="*";
    fi
    if [[ $month -eq 0 ]];
    then
    month="*";
    fi
    if [[ $month -gt 12 || $month -lt 1 || $month -ne "*" || $dayOfMonth -gt 31 || $dayOfMonth -lt 1 || $dayOfMonth -ne "*" ]];
    then
    echo "Error : Введены некорректные данные";
    echo "Введите корректные данные";
    else
        break
        fi
        done
    }


showBackUp() {
    echo -e "    Информация об установленном резервировании ";
    crontab -l |grep -E 'czf|dd' |grep -n ".*" ;
}
delBackUp() {
    echo -n "Выберите операцию, которую надо измененить : ";
    read choose
    crontab -l | grep -v "$searchparam" | {
        cat
        crontab -l | grep "$searchparam" | sed "$choose d"
    } | crontab -
}
while [[ True ]];
do
    clear
    echo -e "    Добро пожаловать в Резервированное Копирование с данных !!!";
echo "(1) Показать параметры резервирования";
echo "(2) Установить резервирование";
echo "(3) Изменить параметры резервирования";
echo "(4) Удалить резервирование";
echo "(5) Выход";
echo -n "    Действие : ";
read command;
clear
case $command in
    "1")
    showBackUp;
    read -n 1 -s -r -p "Нажмите на любую клавишу для возвращения в главное меню"
    ;;
    "2")
    setOperation;
    ;;
    "3")
    showBackUp;
    delBackUp;
    setOperation;
    ;;
    "4")
    showBackUp;
    delBackUp;
    ;;
    "5") 
    break ;;
    *)
    echo "Error : Некорректная команда (перезапуск через 5 секунд)";
    sleep 5;
    ;;
    esac
    done
