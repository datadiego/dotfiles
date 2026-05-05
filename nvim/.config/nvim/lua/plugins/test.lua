return {
  -- Tema Drácula
  { "Mofiqul/dracula.nvim", lazy = false },

  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "dracula" },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = { options = { theme = "dracula-nvim" } },
  },

  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
    enabled = true, -- asegúrate de no deshabilitarlo después
  },

  -- Ejemplo: nvim-cmp con emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
  },
}
