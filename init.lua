vim.g.mapleader = " "

require("config.options")
require("config.keymaps")
require("config.autocommands")
require("config.usercommands")
require("utils")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.runtimepath:prepend(lazypath)

-- setup lazy and loa lua/ directory
require("lazy").setup({ import = "plugins" }, {
  change_detection = {
    notify = false
  },
})
