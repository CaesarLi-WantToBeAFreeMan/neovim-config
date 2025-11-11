--shorthand
local set = function(mode, key, action, description)
    vim.keymap.set(mode, key, action, {noremap = true, silent = true, desc = description})
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

-- ============ window ============
set("n", "<C-h>",    "<C-w>h",                  "go to left window")
set("n", "<C-j>",    "<C-w>j",                  "go to lower window")
set("n", "<C-k>",    "<C-w>k",                  "go to upper window")
set("n", "<C-l>",    "<C-w>l",                  "go to right window")
set("n", "<A-h>",    "<cmd>vert res -2<CR>",    "decrease window width with 2 columns")
set("n", "<A-j>",    "<cmd>res -2<CR>",         "decrease window height with 2 rows")
set("n", "<A-k>",    "<cmd>res +2<CR>",         "increase window height with 2 rows")
set("n", "<A-l>",    "<cmd>vert res +2<CR>",    "increase window width with 2 columns")

-- ============ buffers ============
set("n", "[b", "<cmd>bp<CR>",   "go to previous buffer")
set("n", "]b", "<cmd>bn<CR>",   "go to next buffer")

-- ============ toggles ============
set({"n", "i"}, "<leader>tw",   function() vim.wo.wrap = not vim.wo.wrap end,                       "toggle wrap")
set({"n", "i"}, "<leader>tl",   function() vim.wo.number = not vim.wo.number end,                   "toggle line numbers")
set({"n", "i"}, "<leader>tL",   function() vim.wo.relativenumber = not vim.wo.relativenumber end,   "toggle relative line numbers")
set({"n", "i"}, "<leader>ts",   function() vim.wo.spell = not vim.wo.spell end,                     "toggle spell checker")

-- ============ LSP ============
local goto_prev = vim.diagnostic.goto_prev
local goto_next = vim.diagnostic.goto_next
local severity = vim.diagnostic.severity
set("n", "[e", function() goto_prev({severity.ERROR}) end,  "previous error")
set("n", "]e", function() goto_next({severity.ERROR}) end,  "next error")
set("n", "[w", function() goto_prev({severity.WARN}) end,   "previous warning")
set("n", "]w", function() goto_next({severity.WARN}) end,   "next warning")
set("n", "[h", function() goto_prev({severity.HINT}) end,   "previous hint")
set("n", "]h", function() goto_next({severity.HINT}) end,   "next hint")
set("n", "[i", function() goto_prev({severity.INFO}) end,   "previous info")
set("n", "]i", function() goto_next({severity.INFO}) end,   "next info")
