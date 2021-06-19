# DevOpsCours

## Домашнее задание 1. Bash

Перейти в папку home_task_1

Примеры запуска:
./weather.sh Moscow 
./weather.sh Perm

## Домашнее задание 3. Ansible

Запускаем 2 контейнера в докере на локальной машине. Устанавливаем и запуска в них nginx, 

Перейти в папку home_task_3_ansible, затем:
chmod +x build.sh run-playbook.sh run-server.sh\

#1.соберём образ с ssh на alpine, с подготовленными для установки правами\
./build.sh\
#2.запустим 2 контейнера с открытыми ssh(2222,3333) и web(80,81) портами\
./run-server.sh \
#3.с помощью ansible установим и донастроим(из за alpine) nginx\
sudo ./run-playbook.sh \
#4.проверим что работает\
curl localhost:80\
curl localhost:81\
#получим: DevOps Course 2021 Machine 1, DevOps Course 2021 Machine 2

## Домашнее задание 5. Докер

Перейти в папку home_task_5_docker1
собрать образ скриптом build.sh
запустить образ скриптом run.sh
