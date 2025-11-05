return{
    --inline markdown previewer
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        keys = {
            {"<leader>v", "<cmd>Markview toggle<CR>", desc = "toggle inline markdown preview"},
            {"<leader>V", "<cmd>Markview splitToggle<CR>", desc = "toggle markdow preview in a split window"}
        },
        config = function()
            local set_hl = vim.api.nvim_set_hl
            set_hl(0, "Heading1Color", {fg = "#e06c75", bold = true})
            set_hl(0, "Heading2Color", {fg = "#e5c07b", bold = true})
            set_hl(0, "Heading3Color", {fg = "#98c379", bold = true})
            set_hl(0, "Heading4Color", {fg = "#56b6c2", bold = true})
            set_hl(0, "Heading5Color", {fg = "#61afef", bold = true})
            set_hl(0, "Heading6Color", {fg = "#c678dd", bold = true})

            require("markview").setup({
                preview = {enable = false},                         --disable auto preview
                markdown = {
                    headings = {
                        heading_1 = {sign = "󰲡",    sign_hl = "Heading1Color",  icon = "󰉫 󰚟 %d ",                  hl = "Heading1Color"},
                        heading_2 = {sign = "󰲣",    sign_hl = "Heading2Color",  icon = "󰉬 󰚟 %d.%d ",               hl = "Heading2Color"},
                        heading_3 = {sign = "󰲥",    sign_hl = "Heading3Color",  icon = "󰉭 󰚟 %d.%d.%d ",            hl = "Heading3Color"},
                        heading_4 = {sign = "󰲧",    sign_hl = "Heading4Color",  icon = "󰉮 󰚟 %d.%d.%d.%d ",         hl = "Heading4Color"},
                        heading_5 = {sign = "󰲩",    sign_hl = "Heading5Color",  icon = "󰉯 󰚟 %d.%d.%d.%d.%d ",      hl = "Heading5Color"},
                        heading_6 = {sign = "󰲫",    sign_hl = "Heading6Color",  icon = "󰉰 󰚟 %d.%d.%d.%d.%d.%d ",   hl = "Heading6Color"},
                    }
                }
            })
        end
    }
}
