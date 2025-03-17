# test

Для создания юнита systemd был создан файл monitor.service по пути /etc/systemd/system/ Его настройки:

[Unit]
Description=Мониторинг процесса test 
After=network.target

[Service]
ExecStart=/home/manager/check.sh
Restart=always

[Install]
WantedBy=multi-user.target




Дополнительно.
Чтобы скрипт выполнялся каждую минуту, внесем в cron наши данные
crontab -e
* * * * * /home/manager/check.sh
