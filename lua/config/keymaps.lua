--shorthand
local set = function(mode, key, action, description)
    vim.keymap.set(mode, key, action, {noremap = true, nowait = true, desc = description})
end

--insert \ in insert and command line modes
set({"i", "c"}, "<leader><leader>", "\\", "insert \\")

-- ============ text insertion ============
set("n",        "<Tab>",    "i<Tab><Esc>",      "insert a tab")
set("n",        "<Space>",  "i<Space><Esc>",    "insert a space")
set("n",        "<Del>",    "X",                "delete previous character")
set("n",        "<BS>",     "x",                "delete current character")
set("n",        "<C-n>",    "o<Esc>",           "insert a new line below")
set("n",        "<C-p>",    "O<Esc>",           "insert a new line above")

-- ============ window navigation ============
set({"n", "i"}, "<C-h>",    "<C-w>h",           "go to left window")
set({"n", "i"}, "<C-j>",    "<C-w>j",           "go to below window")
set({"n", "i"}, "<C-k>",    "<C-w>k",           "go to above window")
set({"n", "i"}, "<C-l>",    "<C-w>l",           "go to right window")

-- ============ toggles ============
set({"n", "i"}, "<leader>tw",   function() vim.wo.wrap = not vim.wo.wrap end,                       "toggle wrap")
set({"n", "i"}, "<leader>tl",   function() vim.wo.number = not vim.wo.number end,                   "toggle wrap")
set({"n", "i"}, "<leader>tL",   function() vim.wo.relativenumber = not vim.wo.relativenumber end,   "toggle wrap")
