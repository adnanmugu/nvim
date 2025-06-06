return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  lazy = false,
  branch = 'master',
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-ts-autotag").setup()
    require("nvim-treesitter").setup {
      ensure_installed = {"lua", "vim"},
    }
  end,
}
