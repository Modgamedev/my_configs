return {
  "nvim-neo-tree/neo-tree.nvim",          -- сам плагин Neo-tree
  branch = "v3.x",                        -- ветка плагина
  dependencies = {
    "nvim-lua/plenary.nvim",              -- зависимость: утилиты Lua
    "MunifTanjim/nui.nvim",               -- зависимость: UI-компоненты
    "nvim-tree/nvim-web-devicons",        -- зависимость: иконки файлов
  },
  -- Конфигурация neo-tree
  opts = {
    close_if_last_window = true,             -- закрывать Neo-tree, если больше нет окон
    enable_git_status = true,                -- показывать git-статус
    open_files_using_relative_paths = true,  -- открывать файлы с относительными путями
    -- Настройки окна neo-tree
    window = {
      position = "left",                     -- позиция окна (слева)
      width = 30,                            -- ширина окна
    },
    -- Настройки внешнего вида компонентов
    default_component_configs = {
      container = {
        enable_character_fade = true,        -- края названия длинных файлов "затухают"
      },
    },
    -- Настройки буфера обмена
    clipboard = {
      sync = "universal",                    -- копирование доступно во всех Neovim и в системе
    },
    -- Настройки отступов и стрелок в дереве
    indent = {
      indent_size = 2,                       -- размер одного уровня вложенности в пробелах
      padding = 1,                           -- дополнительный отступ слева
      -- линии отступов
      with_markers = true,                   -- включить линии отступов (guides)
      indent_marker = "│",                   -- символ для вертикальных линий
      last_indent_marker = "└",              -- символ для последнего элемента ветки
      highlight = "NeoTreeIndentMarker",     -- группа подсветки для линий отступов
      -- стрелки для вложенных файлов/папок
      with_expanders = nil,                   -- nil = включить автоматические стрелки, если включено вложение файлов
      expander_collapsed = "",               -- символ для свернутой папки
      expander_expanded = "",                -- символ для раскрытой папки
      expander_highlight = "NeoTreeExpander", -- группа подсветки для стрелок
    },
  },
}
