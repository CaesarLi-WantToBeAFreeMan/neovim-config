--code outline window
return{
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
            "<F2>",
            "<cmd>AerialToggle!<CR>",
            desc = "toggle aerial window",
            mode = "n"
        },
        {
            "<S-F2>",
            "<cmd>AerialNavToggle<CR>",
            desc = "toggle aerial navigation window",
            mode = "n"
        },
        {
            "[a",
            "<cmd>AerialPrev<CR>",
            desc = "previous symbol",
            mode = "n"
        },
        {
            "]a",
            "<cmd>AerialNext<CR>",
            desc = "next symbol",
            mode = "n"
        },
    },
    config = function()
        require("aerial").setup({
            --priority list of preferred backends
            backends = {"treesitter", "lsp", "markdown", "man"},

            --[[
                +-=========-+
                | LAYOUT    |
                +-=========-+
            ]]
            layout = {
                max_width = 0.5,--maximum 50% of screen
                width = nil,--auto-size
                min_width = 0.3,--minimum 30% of screen
                default_direction = "right",--position: left, right, float
                placement = "window",--placement for different windows: window, edge
            },
            attach_mode = "window",--window, global
            close_automatic_events = {},--events to auto-close aerial

            --[[
                +-=========-+
                | KEYMAPS   |
                +-=========-+
            ]]
            keymaps = {
                ["v"] = "actions.jump_vsplit",--like <C-v>
                ["h"] = "actions.jump_split",--like <C-s>
                ["<Esc>"] = "actions.close",
                ["q"] = "actions.close",
                ["p"] = "actions.scroll",
                ["<C-u>"] = "actions.up_and_scroll",
                ["<C-d>"] = "actions.down_and_scroll",
                ["k"] = "actions.prev",
                ["j"] = "actions.next",
                ["K"] = "actions.prev_up",
                ["J"] = "actions.next_up",
                ["x"] = "actions.tree_toggle",
                ["X"] = "actions.tree_toggle_recursive",
                ["o"] = "actions.tree_open",
                ["O"] = "actions.tree_open_recursive",
                ["c"] = "actions.tree_close",
                ["C"] = "actions.tree_close_recursive",
                ["zr"] = "actions.tree_increase_fold_level",
                ["zR"] = "actions.tree_open_all",
                ["zm"] = "actions.tree_decrease_fold_level",
                ["zM"] = "actions.tree_close_all",
                ["zx"] = "actions.tree_sync_folds",
                ["zX"] = "actions.tree_sync_folds",
            },

            --filter which symbols to display
            filter_kind = {
                "Class",
                "Constructor",
                "Enum",
                "Function",
                "Interface",
                "Module",
                "Method",
                "Struct",
            },

            icons = {
                Array         = " ",
                Boolean       = " ",
                Class         = " ",
                Color         = " ",
                Constant      = " ",
                Constructor   = " ",
                Enum          = " ",
                EnumMember    = " ",
                Event         = " ",
                Field         = " ",
                File          = " ",
                Folder        = " ",
                Function      = "󰡱 ",
                Interface     = " ",
                Key           = "󰌋 ",
                Keyword       = " ",
                Method        = " ",
                Module        = "󰕳 ",
                Namespace     = " ",
                Null          = "󰟢 ",
                Number        = "󰎠 ",
                Object        = "󰅩 ",
                Operator      = " ",
                Package       = " ",
                Property      = " ",
                String        = " ",
                Struct        = " ",
                TypeParameter = " ",
                Variable      = "󰫧 ",
            },

            show_guides = true,--show symbol path in window title

            highlight_on_hover = true,
            highlight_on_jump = 210,--in ms

            open_automatic = false,--auto-open aerial when opening supported files
            close_on_select = true,--auto-close aerial when this is the last window
            close_automatic_events = {"unsupported"},--auto-close when is the last window
            --update aerial when entering a new buffer
            update_events = "TextChanged,InsertLeave",
            treesitter = {
                update_delay = 210,
            },

            lsp = {
                diagnostics_trigger_update = true,
                update_when_errors = true,
                update_delay = 210,
            },
        })
    end,
}
