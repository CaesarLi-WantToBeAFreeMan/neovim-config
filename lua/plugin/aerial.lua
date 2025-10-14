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
            "<cmd>AerialToggle<CR>",
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
                --opening
                ["v"] = {
                    "actions.jump_vsplit",
                    desc = "jump to the tag in a vertical split"
                },
                ["<C-v>"] = "none",
                ["h"] = {
                    "actions.jump_split",
                    desc = "jump to the tag in a horizontal split"
                },
                ["<C-s>"] = "none",

                --jumping
                ["k"] = {
                    "actions.prev",
                    desc = "previous tag"
                },
                ["{"] = "none",
                ["j"] = {
                    "actions.next",
                    desc = "next tag"
                },
                ["}"] = "none",
                ["K"] = {
                    "actions.prev_up",
                    desc = "previous tag at parent level"
                },
                ["[["] = "none",
                ["J"] = {
                    "actions.next_up",
                    desc = "next tag at parent level"
                },
                ["]]"] = "none",
                ["<CR>"] = {
                    "actions.jump",
                    desc = "jump to tag under cursor"
                },
                ["<2-LeftMouse>"] = "none",

                --expand/collapse
                ["o"] = {
                    "actions.tree_open",
                    desc = "open folder"
                },
                ["zo"] = "none",
                ["l"] = "none",
                ["O"] = {
                    "actions.tree_open_recursive",
                    desc = "open all sub-folders"
                },
                ["zO"] = "none",
                ["L"] = "none",
                ["c"] = {
                    "actions.tree_close",
                    desc = "close folder"
                },
                ["zc"] = "none",
                ["C"] = {
                    "actions.tree_close_recursive",
                    desc = "close all sub-folders"
                },
                ["zC"] = "none",
                ["H"] = "none",
                ["x"] = {
                    "actions.tree_toggle",
                    desc = "toggle folder open/close"
                },
                ["za"] = "none",
                ["X"] = {
                    "actions.tree_toggle_recursive",
                    desc = "toggle all sub-folders open/close"
                },
                ["zA"] = "none",

                --scrolling
                ["p"] = {
                    "actions.scroll",
                    desc = "scroll to tag without jumping (preview)"
                },
                ["<C-k>"] = {
                    "actions.up_and_scroll",
                    desc = "previous tag and scroll preview"
                },
                ["<C-j>"] = {
                    "actions.down_and_scroll",
                    desc = "next tag and scroll preview"
                },

                --folding
                ["zr"] = {
                    "actions.tree_increase_fold_level",
                    desc = "open one fold level"
                },
                ["zR"] = {
                    "actions.tree_open_all",
                    desc = "open all folds"
                },
                ["zm"] = {
                    "actions.tree_decrease_fold_level",
                    desc = "close one fold level"
                },
                ["zM"] = {
                    "actions.tree_close_all",
                    desc = "close all folds"
                },
                ["zx"] = {
                    "actions.tree_sync_folds",
                    desc = "sync folds with code"
                },

                --other
                ["<Esc>"] = {
                    "actions.close",
                    desc = "close Aerial window"
                },
                ["q"] = {
                    "actions.close",
                    desc = "close Aerial window"
                },
                ["?"] = {
                    "actions.show_help",
                    desc = "show all keymaps"
                },
                ["g?"] = "none",
            },

            --filter which symbols to display
            filter_kind = false,--show all symbol types

            show_guides = true,--show symbol path in window title

            highlight_on_hover = true,
            highlight_on_jump = 210,--in ms

            open_automatic = false,--auto-open aerial when opening supported files
            close_on_select = true,--auto-close aerial after jump
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
