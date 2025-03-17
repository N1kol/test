#!/bin/bash

# const
PROC_NAME="test"
LOG="/var/log/monitoring.log"
CHECK_URL="https://test.com/monitoring/test/api"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG"
}

PROCESS_PID=$(pgrep -x "$PROC_NAME")

while true; do
    
    if pgrep -x "$PROC_NAME" > /dev/null; then
        log_message "Процесс '$PROC_NAME' запущен."
        if [[ "$PROCESS_PID" != "$(pgrep -x "$PROC_NAME")" ]]; then
            log_message "Процесс '$PROC_NAME' был перезапущен."
        fi
    fi

    CHECK_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$CHECK_URL")

    if [ "$CHECK_CODE" -ne 200 ]; then
        log_message "Сервер мониторинга недоступен. Код ответа: $CHECK_CODE"
    else
        log_message "Сервер мониторинга доступен. Код ответа: $CHECK_CODE"
    fi
    PROCESS_PID=$(pgrep -x "$PROC_NAME")

done
