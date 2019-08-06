#!/bin/bash

searchparam="home/work/cron_project/Music"

setMusic() {
	Musiclist=$(ls /$searchparam/ | grep -n ".mp3")
	if [[ $Musiclist == "" ]]; then
		echo "Нет музыки в папке";
	else
		echo -e "Список песен : ";
		echo "$Musiclist";
		Musiclist=($Musiclist)
		echo -n "Выберите одну из песен : ";
		read num;
		chosedMusic=$(echo ${Musiclist[$num - 1]} | sed s/[0-9]*':'//);
		echo $chosedMusic;
	fi
}

setPlayer() {
	playerlist=$(apt list --installed 2>~/null| grep "^mpg321/\|^clementina/\|^rhythmbox/\|^amarok/\|^mplayer/" 2>~/err.out| sed "s/[/].*//g" | grep -n ".*")
	if [[ $playerlist == "" ]]; then
		installPlayser;
	else
		echo -e "Список плееров : ";
		echo "$playerlist"
		playerlist=($playerlist)
		echo -n "Выберите один из плееров : ";
		read num;
		echo ${playerlist[$num - 1]};
		chosedPlayer=$(echo ${playerlist[$num - 1]} | sed s/[0-9]*':'//);
		echo $chosedPlayer;
	fi
}

installPlayser() {
	chosedPlayer="";
	echo "	Рекомендуемые к установки плееры:";
	echo "1) mpg321";
	echo "2) clementina";
	echo "3) rhythmbox";
	echo "4) amarok";
	echo "5) mplayer";
	echo -n "Выберите один из плееров : ";
	read num;
	case $num in
			"1") chosedPlayer+="mpg321" ;;
			"2") chosedPlayer+="clementina" ;;
			"3") chosedPlayer+="rhythmbox" ;;
			"4") chosedPlayer+="amarok" ;;
			"5") chosedPlayer+="mplayer" ;;
			 *) ;;
			esac
	sudo apt install $chosedPlayer
	
}
setTimes() {
echo -e "Введите время срабатывания (через пробел!!!) Час Минута";
	while [[ True ]]; do
		read hour min
		if [[ $hour -gt 23 || $month -lt 0 || $min -gt 59 || $min -lt 0 ]]; then
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
	while [[ True ]]; do
		read dayOfMonth month
		if [[ $dayOfMonth -eq 0 ]]; then 
		dayOfMonth="*";
		fi
		if [[ $month -eq 0 ]]; then 
		month="*";
		fi
		if [[ $month -gt 12 || $month -lt 1 || $month -ne "*" || $dayOfMonth -gt 31 || $dayOfMonth -lt 1 || $dayOfMonth -ne "*" ]]; then
			echo "Error : Введены некорректные данные";
			echo "Введите корректные данные";
		else
			break
		fi
	done
}

newAlarm() {
	setTimes;
	clear;
	setDays;
	clear;
	setPlayer;
	clear;
	setMusic;
	clear;
	crontab -l | { cat; echo "$min $hour $dayOfMonth $month * DISPLAY=:0 $chosedPlayer /$searchparam/$chosedMusic"; } | crontab -
}

delAlarm() {
	echo -n "Выберите будильник, который будет изменен : ";
	read choose
	crontab -l | grep -v "$searchparam" | {
		cat
		crontab -l | grep "$searchparam" | sed "$choose d"
	} | crontab -
}

showAlarms() {
	echo -e "    Информация об установленных будильниках ";
	crontab -l | grep cron_project| grep -n ".*" 
}

while [[ True ]]; do
	clear
	echo -e "    Добро пожаловать !!!";
	echo "(1) Показать список будильников";
	echo "(2) Установить новый будильник";
	echo "(3) Изменить конкретный будильник";
	echo "(4) Удалить конкретный будильник";
	echo "(5) Выход";
	echo -n "    Действие : ";
	read command;
	clear
	case $command in
	"1")
		showAlarms;
		read -n 1 -s -r -p "Нажмите на любую клавишу для возвращения в главное меню"
		;;
	"2") newAlarm ;;
	"3")
		showAlarms;
		delAlarm;
		newAlarm;
		;;
	"4")
		showAlarms;
		delAlarm
		;;
	"5") break ;;
	*)
		echo "Error : Некорректная команда (перезапуск через 5 секунд)";
		sleep 5;
		;;
	esac
done
