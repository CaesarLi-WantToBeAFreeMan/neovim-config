--shorthand
local set = function(mode, key, action, description)
    vim.keymap.set(mode, key, action, { noremap = true, silent = true, desc = description })
end

--insert \ in insert and command line modes
set({ "i", "c" }, "<leader><leader>", "\\", "insert \\")

-- === text insertion ===
set("n", "<Tab>", "i<Tab><Esc>", "insert a tab")
set("n", "<Space>", "i<Space><Esc>", "insert a space")
set("n", "<Del>", "X", "delete previous character")
set("n", "<BS>", "x", "delete current character")
set("n", "<C-n>", "o<Esc>", "insert a new line below")
set("n", "<C-p>", "O<Esc>", "insert a new line above")

-- === auto-top scroll ===
set("n", "<C-d>", "<C-d>zt", "scroll down half page then top")
set("n", "<C-f>", "<C-f>zt", "scroll down full page then top")
set("n", "<C-e>", "<C-e>zt", "scroll down one line then top")
set("n", "<C-u>", "<C-u>zt", "scroll up half page then top")
set("n", "<C-b>", "<C-b>zt", "scroll up full page then top")
set("n", "<C-y>", "<C-y>zt", "scroll up one line then top")

-- === auto-top jump ===
set("n", "<C-o>", "<C-o>zt", "jump backward then top")
set("n", "<C-i>", "<C-i>zt", "jump forward then top")

-- === delete ===
set("n", "<leader>d", "\"_d", "delete without yank")
set("n", "<leader>D", "\"_D", "delete to line end without yank")

-- === windows ===
set("n", "<C-h>", "<C-w>h", "go to left window")
set("n", "<C-j>", "<C-w>j", "go to lower window")
set("n", "<C-k>", "<C-w>k", "go to upper window")
set("n", "<C-l>", "<C-w>l", "go to right window")
set("n", "<A-h>", "<cmd>vert res +2<CR>", "increase window width with 2 columns")
set("n", "<A-j>", "<cmd>res -2<CR>", "decrease window height with 2 rows")
set("n", "<A-k>", "<cmd>res +2<CR>", "increase window height with 2 rows")
set("n", "<A-l>", "<cmd>vert res -2<CR>", "decrease window width with 2 columns")
set("n", "<leader>w=", "<cmd>wincmd =<CR>", "equalize split sizes")
set("n", "<leader>wx", "<C-w>x", "swap current split with next")

-- === tabs ===
set("n", "]t", "<cmd>tabn<CR>", "go to next tab")
set("n", "[t", "<cmd>tabp<CR>", "go to previous tab")
set("n", "<leader>tn", "<cmd>tabnew<CR>", "new tab")
set("n", "<leader>tx", "<cmd>tabc<CR>", "close current tab")
set("n", "<leader>tX", "<cmd>tabo<CR>", "close all other tabs")

-- === buffers ===
set("n", "[b", "<cmd>bp<CR>", "go to previous buffer")
set("n", "]b", "<cmd>bn<CR>", "go to next buffer")
set("n", "<leader>bn", "<cmd>enew<CR>", "new buffer")
set("n", "<leader>bx", "<cmd>bd<CR>", "close current buffer")
set("n", "<leader>bX", "<cmd>%bd|e#|bd#<CR>", "close all other buffers")

-- === toggles ===
set({ "n", "i" }, "<leader>tw", function() vim.wo.wrap = not vim.wo.wrap end, "toggle wrap")
set({ "n", "i" }, "<leader>tl", function() vim.wo.number = not vim.wo.number end, "toggle line numbers")
set(
    { "n", "i" },
    "<leader>tL",
    function() vim.wo.relativenumber = not vim.wo.relativenumber end,
    "toggle relative line numbers"
)
set({ "n", "i" }, "<leader>ts", function() vim.wo.spell = not vim.wo.spell end, "toggle spell checker")
set({ "n", "i" }, "<leader>td", function()
    local tinyInlineDiagnostic = require("tiny-inline-diagnostic")
    tinyInlineDiagnostic.toggle()
    vim.g.inline_diag_enabled = not vim.g.inline_diag_enabled
    vim.notify(vim.g.inline_diag_enabled and "inline diagnostics on" or "inline diagnostics off", vim.log.levels.INFO)
end, "toggle inline diagnostics")

-- === search ===
set("n", "<Esc>", "<cmd>noh<CR><Esc>", "clear search highlight")
set("n", "*", "*N", "highlight word under cursor without jumping")

-- === move lines ===
set("n", "<leader>j", "<cmd>m .+1<CR>==", "move line down")
set("n", "<leader>k", "<cmd>m .-2<CR>==", "move line up")
set("v", "<leader>j", ":m '>+1<CR>gv=gv", "move selection down")
set("v", "<leader>k", ":m '<-2<CR>gv=gv", "move selection up")

-- === command line ===
vim.keymap.set("c", "<C-j>", "<Down>", { desc = "next command history" })
vim.keymap.set("c", "<C-k>", "<Up>", { desc = "previous command history" })
vim.keymap.set(
    "c",
    "%%",
    function() return vim.fn.expand("%:h") .. "/" end,
    { expr = true, desc = "expend to current file directory" }
)
