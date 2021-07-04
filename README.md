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
 
**Ansible** - cоздаем конфиг, "html" страницу для nginx, копируем скрипт запуска докера в целевой машине
**Docker** - запускаем образ nginx, через volume подставляем наш конфиг и "html" страницу

### Git:
- Пуш в мастер запрещен(**protected branch**)
- При пуше и пуллреквесте в любые ветке проводятся три проверки, мердж в мастер разрешён если во всех ок:
**GitHub-Actions-DevOpsCours** - тестовая проверка(проверка того что проверки работают =)  )
**Validate terraform** - валидация файлов терраформа
**Ansible-lint** - валидация плейбука ansible
![alt text](https://drive.google.com/uc?export=view&id=1pAEZqnXkKKTtnmE5wrHcmrFEOgNsmz-k)