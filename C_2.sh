#!/bin/bash

# Задание 2 части C
# При необходимости развернуть проект на нескольких станциях удаленно
# Можно посылать этот скрипт на удаленную машину и выполнять его
# Скрипт сам копирует файлы с GitLab и запускает скрипты установки 

$path = ./home/user/project

# Клонируем репозиторий
git clone "https://ссылка_на_репозиторий_gitlab/repo.git/" $path
# Переходим в папку со скериптами
cd $path/scripts
# При необходимости можно добавить chmod +X 
# Выполняем скрипт предустановки
sh ./preinstall.sh
# Добавляем выполнение функции после перезагрузки
@reboot post_install()
# Функция доустановки 
post_install () {
    cd $path/scripts
    sh ./postinstall.sh
}
# Перезагружаем систему
shutdown -r now