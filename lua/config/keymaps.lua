--shorthand
local map = vim.keymap.set

--insert \ in insert and command line modes
map({"i", "c"}, "<leader><leader>", "\\",   {noremap = true,    silent = true,  desc = "insert \\ in insert mode"})

-- ============ buffer ============
map("n",    "<leader>b",    ":ls<CR>",              {silent = true,  desc = "list all buffers"})
map("n",    "<leader>n",    ":vert sbn<CR>",        {silent = true,  desc = "vertically split next buffer"})
map("n",    "<leader>p",    ":vert sbp<CR>",        {silent = true,  desc = "vertically split previous buffer"})
map("n",    "<leader>f",    ":vert sbf<CR>",        {silent = true,  desc = "vertically split first buffer"})
map("n",    "<leader>l",    ":vert sbl<CR>",        {silent = true,  desc = "vertically split last buffer"})

map("n",    "<leader>N",    ":w<CR>:vert sbn<CR>",  {silent = true,  desc = "save and vertically split next buffer"})
map("n",    "<leader>P",    ":w<CR>:vert sbp<CR>",  {silent = true,  desc = "save and vertically split previous buffer"})
map("n",    "<leader>F",    ":w<CR>:vert sbf<CR>",  {silent = true,  desc = "save and vertically split first buffer"})
map("n",    "<leader>L",    ":w<CR>:vert sbl<CR>",  {silent = true,  desc = "save and vertically split last buffer"})

-- ============ text insertion ============
map("n",    "<Tab>",        "i<Tab><Esc>",          {silent = true,  desc = "insert a tab"})
map("n",    "<Space>",      "i<Space><Esc>",        {silent = true,  desc = "insert a space"})
map("n",    "<Del>",        "X",                    {silent = true,  desc = "delete previous character"})
map("n",    "<BS>",         "x",                    {silent = true,  desc = "delete current character"})
map("n",    "<C-n>",        "o<Esc>",               {silent = true,  desc = "insert a new line below"})
map("n",    "<C-p>",        "O<Esc>",               {silent = true,  desc = "insert a new line above"})
