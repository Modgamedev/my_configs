return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Иконки (опционально)
    config = function()
      require('lualine').setup {
        -- Общие настройки Lualine
        options = {
          icons_enabled = true,                      -- Включить иконки
          theme = 'auto',                            -- Автоматическая тема
          component_separators = { left = '', right = '' }, -- Разделители компонентов
          section_separators = { left = '', right = '' },   -- Разделители секций
          disabled_filetypes = {                     -- Не показывать в этих типах буферов
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},                         -- Игнорируемые окна
          always_divide_middle = true,               -- Разделять секции по центру
          always_show_tabline = true,                -- Всегда показывать таблайн (вкладки)
          globalstatus = false,                      -- Отдельная статусная строка для каждого окна
          refresh = {                                -- Частота обновления
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 16,                       -- ~60 FPS
            events = {                               -- События для обновления
              'WinEnter', 'BufEnter', 'BufWritePost', 'SessionLoadPost',
              'FileChangedShellPost', 'VimResized', 'Filetype',
              'CursorMoved', 'CursorMovedI', 'ModeChanged',
            },
          },
        },

        -- Основные секции статусной строки
        sections = {
          lualine_a = { 'mode' },                    -- Текущий режим (Normal/Insert и т.д.)
          lualine_b = { 'branch', 'diff', 'diagnostics' }, -- Git-ветка, изменения, диагностика
          lualine_c = { 'filename' },                -- Имя файла
          lualine_x = { 'encoding', 'fileformat', 'filetype' }, -- Кодировка, формат, тип файла
          lualine_y = { 'progress' },                -- Прогресс по файлу
          lualine_z = { 'location' },                -- Позиция курсора
        },

        -- Настройки для неактивных окон
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },

        -- Таблайн (строка вкладок)
        tabline = {},
        -- Винбар (строка заголовка окна)
        winbar = {},
        -- Винбар для неактивных окон
        inactive_winbar = {},
        -- Расширения для интеграции с другими плагинами
        extensions = {},
      }
    end,
  },
}
