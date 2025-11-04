return {
    "stevearc/aerial.nvim",--code outline/symbol tree viewer
    dependencies = {
        "nvim-treesitter/nvim-treesitter",  --used for syntax tree parsing
        "nvim-tree/nvim-web-devicons"       --file icons
    },

    keys = {
        {"<F2>",    "<cmd>AerialToggle<CR>",       desc = "toggle aerial window",              mode = "n"},
        {"<S-F2>",  "<cmd>AerialNavToggle<CR>",    desc = "toggle aerial navigation window",   mode = "n"},
        {"[a",      "<cmd>AerialPrev<CR>",          desc = "jump to previous symbol",           mode = "n"},
        {"]a",      "<cmd>AerialNext<CR>",          desc = "jump to next symbol",               mode = "n"},
        {
            "<leader>fa",  function()
                require("telescope").extensions.aerial.aerial()
            end,
            desc = "fuzzy search aerial symbols",
            mode = "n"
        }
    },

    config = function()
        require("aerial").setup({
            backends = {"treesitter", "lsp", "markdown", "man"},--use treesitter and LSP for symbol data
            lazy_load = true,                 --don't load aerial until call it
            attach_mode = "window",           --attach aerial per window
            autojump = false,                 --disable auto-jump
            close_on_select = true,           --close when selecting via default mapping
            highlight_on_hover = true,
            highlight_on_jump = 210,
            post_jump_cmd = "normal! zt",     --set the symbol line at the top
            show_guides = true,               --display characters for tree hierarchy
            filter_kind = {
                "Variable", "Function", "Enum", "Class", "Method",
                "Constructor", "Field", "Struct", "Property", "Tag", "Heading"
            },
            icons = {                         --custom icons
                Function = "󰡱",
                Method = "󰊕",
                Variable = "󰫧",
                Field = "󰬅",
                Enum = "󱡠",
                Struct = "󰬚",
                Class = "󰬊",
                Constructor = "󰩀",
                Property = "󰬗",
                Tag = "",
                Heading = ""
            },
            close_automatic_events = {"unfocus"},   --close aerial when leaving
            layout = {
                default_direction = "right",  --open aerial at right
                placement = "edge",           --open at the far right of the editor
                min_width = 50,
            },
            keymaps = {
                ["<2-LeftMouse>"] = false,
                ["l"] = false,
                ["L"] = false,
                ["H"] = false,
                ["h"] = "actions.jump_split",
                ["<C-s>"] = false,
                ["v"] = "actions.jump_vsplit",
                ["<C-v>"] = false,
                ["<Esc>"] = "actions.close",
                ["<C-k>"] = "actions.prev",
                ["{"] = false,
                ["<C-j>"] = "actions.next",
                ["}"] = false,
                ["K"] = "actions.prev_up",
                ["[["] = false,
                ["J"] = "actions.next_up",
                ["]]"] = false,
                ["gk"] = "actions.up_and_scroll",
                ["gj"] = "actions.down_and_scroll",
            },

            --auto-close Aerial if it's the last window
            vim.api.nvim_create_autocmd(
                "BufEnter",
                {
                    group = vim.api.nvim_create_augroup("AerialAutoClose", {clear = true}),
                    callback = function()
                        local layout = vim.fn.winlayout()
                        if layout [1] == "lead"
                            and vim.bo [vim.api.nvim_win_get_buf(layout [2])].filetype == "aerial"
                            and not layout [3]
                        then
                            vim.cmd("quit")
                        end
                    end

                }
            )
        })
    end
}
