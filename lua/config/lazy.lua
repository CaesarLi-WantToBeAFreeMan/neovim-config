--define the installation path for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

--check if lazy.nvim is not already installed
if not vim.loop.fs_stat(lazypath) then
	--if missing, clone it from GitHub into the specified path
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",                       --don’t download unnecessary file history
        "https://github.com/folke/lazy.nvim.git",   --official Lazy.nvim repository
        "--branch=stable",                          --use the stable branch
        lazypath,                                   --clone destination path
    })
end

--add lazy.nvim to Neovim’s runtime path
vim.opt.rtp:prepend(lazypath)

--initialize lazy.nvim and load all plugins from the "plugin" directory
require("lazy").setup("plugin", {
    ui = { border = "rounded" },            --use rounded borders for Lazy’s UI wins
    checker = { enabled = false },          --disable automatic update checg
    change_detection = { notify = false },  --don’t show messages when plugin files change
})
