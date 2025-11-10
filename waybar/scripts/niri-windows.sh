#!/usr/bin/env bash
set -euo pipefail

# Получаем snapshot данных
WORKSPACES_JSON=$(niri msg --json workspaces 2>/dev/null || echo "[]")
WINDOWS_JSON=$(niri msg --json windows 2>/dev/null || echo "[]")

# Активный workspace и активное окно
REAL_ID=$(echo "$WORKSPACES_JSON" | jq -r '.[] | select(.is_active == true) | .id // empty')
ACTIVE_WINDOW_ID=$(echo "$WINDOWS_JSON" | jq -r '.[] | select(.is_focused == true) | .id // empty')

# Если не найден активный workspace — выводим заглушку
if [[ -z "$REAL_ID" ]]; then
  jq -c -n '{"text":"—","class":"active-windows"}'
  exit 0
fi

# Сопоставление app_id -> иконка (можно расширить)
# Собираем строку в jq и возвращаем с <span class="active">...</span> для активного окна
TEXT=$(echo "$WINDOWS_JSON" | jq -r --arg ws_id "$REAL_ID" --arg active_id "$ACTIVE_WINDOW_ID" '
  [ .[]
    | select(.workspace_id == ($ws_id | tonumber))
    | {
        pos: (.layout.pos_in_scrolling_layout[0] // 9999),
        app: (.app_id // ""),
        id: (.id | tostring)
      }
    # map app -> icon (дополни по нужным app_id)
    | (if .app == "firefox" then "🌎"
       elif .app == "foot" then "💻"
       elif .app == "code" or .app == "vscode" then "🧑‍💻"
       elif .app == "mpv" then "🎬"
       elif .app == "thunar" then ""
       else "📄" end) as $icon
    # если окно активное — оборачиваем в span
    | (if .id == $active_id then "<span class=\"active\">"+$icon+"</span>" else $icon end)
  ]
  | sort_by(.[0].pos?)?    # сортируем по pos (безопасно)
  # Преобразуем массив уже полученных строк: если мы ранее возвращали объект, у нас строки — ok.
  | map(.) | join(" ")
')

# Отдаём компактный JSON для waybar
jq -c -n --arg text "$TEXT" '{"text": $text, "class": "active-windows"}'
