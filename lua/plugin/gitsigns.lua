return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
        local hl = vim.api.nvim_set_hl
        require("gitsigns").setup({
            signs = {
                add = { text = "󰐖" },
                change = { text = "󱗜" },
                delete = { text = "󰍵" },
                topdelete = { text = "󰾟" },
                changedelete = { text = "󰦓" },
                untracked = { text = "󰏬" },
            },
        })

        hl(0, "GitSignsAdd", { fg = "#98c379" })
        hl(0, "GitSignsChange", { fg = "#e5c07b" })
        hl(0, "GitSignsDelete", { fg = "#e06c75" })
        hl(0, "GitSignsTopdelete", { fg = "#e06c75" })
        hl(0, "GitSignsChangedelete", { fg = "#e5c07b" })
        hl(0, "GitSignsUntracked", { fg = "#00ffff" })
    end,
}
