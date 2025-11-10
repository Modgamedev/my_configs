#!/bin/bash

# Кэшируем данные для производительности
WORKSPACES_JSON=$(niri msg --json workspaces)
WINDOWS_JSON=$(niri msg --json windows)

# Получаем активный workspace и окно
REAL_ID=$(echo "$WORKSPACES_JSON" | jq -r '.[] | select(.is_active == true) | .id')
ACTIVE_WINDOW_ID=$(echo "$WINDOWS_JSON" | jq -r '.[] | select(.is_focused == true) | .id')

# Формируем отсортированный список иконок
TEXT=$(echo "$WINDOWS_JSON" | jq -r --arg ws_id "$REAL_ID" --arg active_id "$ACTIVE_WINDOW_ID" '
.[] | select(.workspace_id == ($ws_id | tonumber)) | 
{
    pos: .layout.pos_in_scrolling_layout[0],
    app: .app_id,
    id: .id
}
| (if .app == "firefox" then "🌎"
  elif .app == "foot" then "💻" 
  else "📄" end) as $icon
| (if (.id | tostring) == $active_id then "*\($icon)*" else "\($icon)" end) as $display
| "\(.pos)|\($display)"
' | sort -n -t '|' -k1 | cut -d'|' -f2 | tr -d '\n' | sed 's/ /* /g')

# Выводим компактный JSON в ОДНУ строку
jq -c -n --arg text "$TEXT" '{"text": $text, "class": "active-windows"}'
