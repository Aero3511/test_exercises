#!/bin/bash

# Задание 3 части C
# Скрипт надо добавить в cron: 0 3 * * * путь_к_скрипту
# Для автоматического запуска в 3 часа ночи

# Узнаем есть ли в каталоге файлы командой ls -la | grep "^-" | wc
# После чего выполняем одно из условий если подходит
case (ls -la | grep "^-" | wc) in
0) dump_mk;; # Если файлы ранее не создавались
1) dump_mk1;; # Если существуют 1 файл
2) dump_mk2;; # Если существуют 2 файла
3) dump_chk;; # Если существуют все 3 файла
esac 

# Создание файла бэкапа и бэкапов для 7 дней и 14
dump_mk(){

    sh ./dump_script.sh > ./home/user/all_backups

    if ( -n -e  ./home/user/all_backups/7_day/dump7.gz)
    then 
    $true = true
    fi

    if ( -n $true )
    then
    mkdir 7_day
    mkdir 14_day
    cp dump.gz ./home/user/all_backups/7_day/dump7.gz
    cp dump.gz ./home/user/all_backups/14_day/dump14.gz
    fi
}

# Создание файла бэкапа при наличии 1 файла
dump_mk1(){
if [ -e ./home/user/all_backups/dump.gz ]
then
    mv dump.gz dump2.gz
   dump_mk()
fi

}

# Замена дампа при наличии 2 файлов
dump_mk2(){

if [ -e ./home/user/all_backups/dump.gz ]
then
if [ -e ./home/user/all_backups/dump2.gz ]
then
    mv dump2.gz dump3.gz
    mv dump.gz dump2.gz
    dump_mk()
fi

}

#Замена дампа при наличии 3 файлов
dump_chk(){

if [ -e ./home/user/all_backups/dump.gz ]
then
if [ -e ./home/user/all_backups/dump2.gz ]
then
if [ -e ./home/user/all_backups/dump3.gz ]
then
    mv dump2.gz dump3.gz
    mv dump.gz dump2.gz
    dump_mk()
fi

}

#Функция проверки наличия файла созданного более 7 дней назад
check_old(){
    if [ find ./home/user/all_backups/7_day/dump7.gz -mtime +7 ]
    then
    dump_sd();
    dump_fd();
    fi
}

# Дамп семидневного файла
dump_sd(){
    mv ./home/user/all_backups/dump.gz ./home/user/all_backups/7_day/dump7.gz
}

# Дамп четырнадцатидневного файла
dump_fd(){
    if [ find ./home/user/all_backups/14_day/dump14.gz -mtime +14 ]
    mv ./home/user/all_backups/dump.gz ./home/user/all_backups/14_day/dump14.gz
    fi
}



