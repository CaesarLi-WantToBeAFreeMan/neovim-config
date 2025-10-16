--shorthand for the keymap
local map = vim.keymap.set

map({"i", "c"}, "<leader><leader>", "\\",   {noremap = true,    silent = true,  desc = "insert \\ in insert mode"})
-- ============ buffer ============
map("n",    "<leader>b",    ":ls<CR>", {
    noremap = true, silent = true,  desc = "list all buffers"
})
map("n",    "<leader>n",    ":vert sbn<CR>", {
    noremap = true, silent = true,  desc = "vertically split next buffer"
})
map("n",    "<leader>p",    ":vert sbp<CR>", {
    noremap = true, silent = true,  desc = "vertically split previous buffer"
})
map("n",    "<leader>f",    ":vert sbf<CR>", {
    noremap = true, silent = true,  desc = "vertically split first buffer"
})
map("n",    "<leader>l",    ":vert sbl<CR>", {
    noremap = true, silent = true,  desc = "vertically split last buffer"
})

map("n",    "<leader>N",    ":w<CR>:vert sbn<CR>", {
    noremap = true, silent = true,  desc = "save then vertically split next buffer"
})
map("n",    "<leader>P",    ":w<CR>:vert sbp<CR>", {
    noremap = true, silent = true,  desc = "save then vertically split previous buffer"
})
map("n",    "<leader>F",    ":w<CR>:vert sbf<CR>", {
    noremap = true, silent = true,  desc = "save then vertically split first buffer"
})
map("n",    "<leader>L",    ":w<CR>:vert sbl<CR>", {
    noremap = true, silent = true,  desc = "save then vertically split last buffer"
})

-- ============ text insertion ============
map("n",    "<Tab>",    "i<Tab><Esc>",      {noremap = true,    silent = true,  desc = "insert a tab"               })
map("n",    "<Space>",  "i<Space><Esc>",    {noremap = true,    silent = true,  desc = "insert a space"             })
map("n",    "<Del>",    "X",                {noremap = true,    silent = true,  desc = "delete previous character"  })
map("n",    "<BS>",     "x",                {noremap = true,    silent = true,  desc = "delete current character"   })
map("n",    "<C-n>",    "o<Esc>",           {noremap = true,    silent = true,  desc = "insert a new line below"    })
map("n",    "<C-p>",    "O<Esc>",           {noremap = true,    silent = true,  desc = "insert a new line above"    })
