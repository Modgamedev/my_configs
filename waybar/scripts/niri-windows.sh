#!/usr/bin/env bash
set -euo pipefail

# Получаем snapshot данных
WORKSPACES_JSON=$(niri msg --json workspaces 2>/dev/null || echo "[]")
WINDOWS_JSON=$(niri msg --json windows 2>/dev/null || echo "[]")

# Активный workspace и активное окно
REAL_ID=$(echo "$WORKSPACES_JSON" | jq -r '.[] | select(.is_active == true) | .id // empty')
ACTIVE_WINDOW_ID=$(echo "$WINDOWS_JSON" | jq -r '.[] | select(.is_focused == true) | .id // empty')

# Если нет активного workspace — выводим заглушку
if [[ -z "$REAL_ID" ]]; then
  jq -c -n '{"text":"—","class":"active-windows"}'
  exit 0
fi

# Формируем список иконок
TEXT=$(echo "$WINDOWS_JSON" | jq -r --arg ws_id "$REAL_ID" --arg active_id "$ACTIVE_WINDOW_ID" '
  [.[] 
    | select(.workspace_id == ($ws_id | tonumber))
    | {
        pos: (.layout.pos_in_scrolling_layout[0] // 9999),
        app: (.app_id // ""),
        id: (.id | tostring)
      }
    | {pos, display: (if .app == "firefox" then "🌎"
                      elif .app == "foot" then "💻"
                      elif .app == "code" or .app == "vscode" then "🧑‍💻"
                      elif .app == "mpv" then "🎬"
                      elif .app == "thunar" then ""
                      else "📄" end
                     | if .id == $active_id then "<span class=\"active\">\(.)</span>" else . end)}
  ]
  | sort_by(.pos)
  | map(.display)
  | join("  ")
')

# Возвращаем Waybar JSON
jq -c -n --arg text "$TEXT" '{"text": $text, "class": "active-windows"}'
