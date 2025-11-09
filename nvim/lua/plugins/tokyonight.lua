return {
  {
    "folke/tokyonight.nvim",  -- название темы
    lazy = false,             -- загружается сразу при старте
    priority = 1000,          -- загружается раньше других плагинов
    config = function()       -- Настройки плагина ниже
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  }
}
