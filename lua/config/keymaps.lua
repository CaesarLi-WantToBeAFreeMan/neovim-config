--shorthand
local map = vim.keymap.set

--insert \ in insert and command line modes
map({"i", "c"}, "<leader><leader>", "\\",   {noremap = true,    silent = true,  desc = "insert \\ in insert mode"})

-- ============ text insertion ============
map("n",    "<Tab>",        "i<Tab><Esc>",          {silent = true,  desc = "insert a tab"})
map("n",    "<Space>",      "i<Space><Esc>",        {silent = true,  desc = "insert a space"})
map("n",    "<Del>",        "X",                    {silent = true,  desc = "delete previous character"})
map("n",    "<BS>",         "x",                    {silent = true,  desc = "delete current character"})
map("n",    "<C-n>",        "o<Esc>",               {silent = true,  desc = "insert a new line below"})
map("n",    "<C-p>",        "O<Esc>",               {silent = true,  desc = "insert a new line above"})
