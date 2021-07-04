# DevOpsCours

## Итоговое задание
* Файлы по итоговому заданию находятся в директории final_exam.

* Инфраструктура:

![alt text](https://drive.google.com/uc?export=view&id=1AIFcJTrIrw-UPe_v7nDKvoGtCmpt1Hu5)

### Терраформ
* module **vpc** - модуль с описанием основной vpc и public подсети в ней
**data "aws_vpcs" "vpc_info"** - хотим получить id подсети для использования в секьюрити группе
* **aws_security_group** **dev_ops_sg** - секьюрити группа, открываем доступ к ssh(22), http(80) извне, и доступ ко всему изнутри
module **ec2_instances** - модуль с описанием ec2 инстансов
* **В output** выводим часть настроек, в том числе результирующий pulic ip ec2 инстанса

### Скрипты:
* **generate_hosts.sh** - на основе шаблона генерируем hosts файл для ansible
* **run_all.sh** - развернуть в aws, задеплоить
* **destroy_all.sh** - удалить из aws
 
Ansible - cоздаем конфиг, "html" страницу для nginx, копируем скрипт запуска докера в целевой машине
Docker - запускаем образ nginx, через volume подставляем наш конфиг и "html" страницу

### Git:
- Пуш в мастер запрещен(**protected branch**)
- При пуше и пуллреквесте в любые ветке проводятся три проверки, мердж в мастер разрешён если во всех ок:
**GitHub-Actions-DevOpsCours** - тестовая проверка(проверка того что проверки работают =)  )
**Validate terraform** - валидация файлов терраформа
**Ansible-lint** - валидация плейбука ansible





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
