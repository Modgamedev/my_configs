#!/bin/bash

echo "Исправленный демон событий запущен в $(date)" > /tmp/niri-events-fixed.log

# Функция для обработки события
handle_event() {
    local event="$1"
    
    # Извлекаем тип события (первый ключ в JSON)
    local event_type=$(echo "$event" | jq -r 'keys[0] // empty')
    
    if [ -n "$event_type" ]; then
        echo "Получено событие: $event_type" >> /tmp/niri-events-fixed.log
        
        case "$event_type" in
            "WorkspacesChanged"|"WindowsChanged"|"WindowFocusChanged"|"WindowOpenedOrChanged"|"WindowClosed"|"WorkspaceActivated"|"WorkspaceActiveWindowChanged")
                echo "Обновляю waybar из-за события: $event_type" >> /tmp/niri-events-fixed.log
                pkill -RTMIN+10 waybar
                ;;
        esac
    fi
}

# Основной цикл
while true; do
    echo "Подключаюсь к event-stream..." >> /tmp/niri-events-fixed.log
    
    niri msg --json event-stream 2>> /tmp/niri-events-fixed.log | while read -r event_line; do
        if [ -n "$event_line" ]; then
            handle_event "$event_line"
        fi
    done
    
    echo "Соединение разорвано, переподключаюсь через 2 секунды..." >> /tmp/niri-events-fixed.log
    sleep 2
done
