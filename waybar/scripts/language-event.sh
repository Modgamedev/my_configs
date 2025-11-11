#!/bin/bash

# Изначально выводим текущий язык один раз
update_layout() {
    layout_json=$(niri msg -j keyboard-layouts)
    current_idx=$(echo "$layout_json" | jq '.current_idx')
    current_layout=$(echo "$layout_json" | jq -r ".names[$current_idx]")

    if [[ "$current_layout" == "English (US)" ]]; then
        text="EN"
        class="en"
    else
        text="РУ"
        class="ru"
    fi

    echo "{\"text\":\"$text\",\"class\":\"$class\"}"
}

# Первый вывод
update_layout

# Слушаем событие keyboard-layout-changed и обновляем модуль мгновенно
niri msg -s keyboard-layout-changed | while read -r _; do
    update_layout
    niri msg 10   # 10 — тот же сигнал, что указан в модуле Waybar
done
