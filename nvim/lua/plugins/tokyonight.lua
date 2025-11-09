return {
  {
    "folke/tokyonight.nvim",  -- название темы
    lazy = false,             -- загружается сразу при старте
    priority = 1000,          -- загружается раньше других плагинов
    opts = {},                -- здесь можно добавить настройки темы, пока пусто
    config = function(_, opts)
      require("tokyonight").setup(opts)  -- применяем настройки
      vim.cmd([[colorscheme tokyonight]]) -- включаем тему
    end,
  }
}
