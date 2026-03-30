--LazyVim installation path
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" --set path for lazy.nvim

--install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then --if missing, clone from GitHub
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none", --don’t download unnecessary file history
        "https://github.com/folke/lazy.nvim.git", --official Lazy.nvim repository
        "--branch=stable", --use the stable branch
        lazypath, --clone destination path
    })
end

--prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath) --add lazy.nvim to Neovim's runtime path

--initialize lazy.nvim with plugins from `plugin` directory
require("lazy").setup({
    spec = {
        { import = "plugin.lsp" }, --load LSP plugins
        { import = "plugin" }, --load other plugins
    },
    ui = {
        border = "rounded",
    },
    rocks = { enabled = false },
    checker = {
        enabled = false, --disable automatic plugin update checks
    },
    change_detection = {
        notify = false, --suppress plugin change notifications
    },
})
