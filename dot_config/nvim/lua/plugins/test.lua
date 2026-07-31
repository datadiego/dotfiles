return {
  -- Tema Gruvbox
  { "ellisonleao/gruvbox.nvim", lazy = false },

  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "gruvbox" },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = { options = { theme = "gruvbox" } },
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
