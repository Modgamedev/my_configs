return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- Настройки Lualine
    opts = {
      -- Общие настройки
      options = {
        icons_enabled = true,         -- Показывать иконки
        theme = 'auto',               -- Тема для строки статуса
        component_separators = { left = '', right = '' },     -- Разделители между элементами внутри одной секции
        section_separators = { left = '', right = '' },       -- Разделители между секциями
        disabled_filetypes = { statusline = {}, winbar = {} },  -- В каких буферах не показывать statusline или winbar
        ignore_focus = {},
        always_divide_middle = true,    -- Делить статусную строку по центру (разделение на левую и правую часть)
        always_show_tabline = false,
        globalstatus = true,            -- Использовать одну глобальную строку статуса для всех окон
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16,
          events = {
            'WinEnter', 'BufEnter', 'BufWritePost', 'SessionLoadPost',
            'FileChangedShellPost', 'VimResized', 'Filetype',
            'CursorMoved', 'CursorMovedI', 'ModeChanged',
          },
        },
      },
      -- Содержание в статусе для активного окна
      sections = {
        lualine_a = { 'mode' },            -- самая левая секция
        lualine_b = { 'branch' },          -- следующая левая секция
        lualine_c = { 'diagnostics' },     -- центральная левая секция
        lualine_x = { 'filetype' },        -- центральная правая секция
        lualine_y = {},                    -- следующая правая секция
        lualine_z = {},                    -- самая правая секция
      },
      -- Содержание в статусе для НЕактивного окна
      inactive_sections = {
        lualine_a = {},                    -- самая левая секция
        lualine_b = {},                    -- следующая левая секция
        lualine_c = {},                    -- центральная левая секция
        lualine_x = {},                    -- центральная правая секция
        lualine_y = {},                    -- следующая правая секция
        lualine_z = {},                    -- самая правая секция
      },
      tabline = {},
      winbar = {
          lualine_c = { 'filename' },      -- показывать имя файла в верхней части окна
      },
      inactive_winbar = {},
      extensions = {},
    },
  },
}
