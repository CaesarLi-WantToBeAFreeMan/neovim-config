--a code outline/symbol tree viewer
return {
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",  --used for syntax tree parsing
        "nvim-tree/nvim-web-devicons",      --file icons
    },

    --keybindings in normal mode
    keys = {
        {"<F2>",    "<cmd>AerialToggle<CR>",    desc = "toggle aerial window",              mode = "n"},
        {"<S-F2>",  "<cmd>AerialNavToggle<CR>", desc = "toggle aerial navigation window",   mode = "n"},
        {"[a",      "<cmd>AerialPrev<CR>",      desc = "jump to previous symbol",           mode = "n"},
        {"]a",      "<cmd>AerialNext<CR>",      desc = "jump to next symbol",               mode = "n"},
    },

    config = function()
        require("aerial").setup({
            --symbol sources
            backends = { "treesitter", "lsp", "markdown", "man" },

            --window layout options
            layout = {
                max_width = 0.5,              --maximum width of Aerial window
                width = nil,                  --auto-calculate width if nil
                min_width = 0.3,              --minimum width
                default_direction = "right",  --open on the right side by default
                placement = "window",         --attach to current window
            },

            attach_mode = "window",          --attach Aerial per window

            --keymaps
            keymaps = {
                --split
                ["v"]       = {"actions.jump_vsplit",   desc = "jump to tag in vertical split"      },
                ["<C-v>"]   = "none",
                ["h"]       = {"actions.jump_split",    desc = "jump to tag in horizontal split"    },
                ["<C-s>"]   = "none",

                --go to
                ["k"]               = {"actions.prev",      desc = "go to previous tag"                 },
                ["{"]               = "none",
                ["j"]               = {"actions.next",      desc = "go to next tag"                     },
                ["}"]               = "none",
                ["K"]               = {"actions.prev_up",   desc = "go to previous parent-level tag"    },
                ["[["]              = "none",
                ["J"]               = {"actions.next_up",   desc = "go to next parent-level tag"        },
                ["]]"]              = "none",
                ["<CR>"]            = {"actions.jump",      desc = "jump to tag under cursor"           },
                ["<2-LeftMouse>"]   = "none",

                --open/close folders
                ["o"]   = {"actions.tree_open",             desc = "open folder"                        },
                ["zo"]  = "none",
                ["l"]   = "none",
                ["O"]   = {"actions.tree_open_recursive",   desc = "open all sub-folders"               },
                ["zO"]  = "none",
                ["L"]   = "none",
                ["c"]   = {"actions.tree_close",            desc = "close folder"                       },
                ["zc"]  = "none",
                ["C"]   = {"actions.tree_close_recursive",  desc = "close all sub-folders"              },
                ["zC"]  = "none",
                ["H"]   = "none",
                ["x"]   = {"actions.tree_toggle",           desc = "toggle folder open/close"           },
                ["za"]  = "none",
                ["X"]   = {"actions.tree_toggle_recursive", desc = "toggle all sub-folders open/close"  },
                ["zA"]  = "none",

                --scroll
                ["p"]       = {"actions.scroll",            desc = "scroll to tag (preview without jumping)"    },
                ["<C-k>"]   = {"actions.up_and_scroll",     desc = "move up and scroll preview"                 },
                ["<C-j>"]   = {"actions.down_and_scroll",   desc = "move down and scroll preview"               },

                --fold
                ["zr"]  = {"actions.tree_increase_fold_level",  desc = "open one fold level"            },
                ["zR"]  = {"actions.tree_open_all",             desc = "open all folds"                 },
                ["zm"]  = {"actions.tree_decrease_fold_level",  desc = "close one fold level"           },
                ["zM"]  = {"actions.tree_close_all",            desc = "close all folds"                },
                ["zx"]  = {"actions.tree_sync_folds",           desc = "sync code folds with Aerial"    },

                --close
                ["<Esc>"]   = {"actions.close", desc = "close Aerial window"},
                ["q"]       = {"actions.close", desc = "close Aerial window"},

                --help
                ["?"]   = {"actions.show_help", desc = "show available keymaps"},
                ["g?"]  = "none",
            },

            --symbol filtering
            filter_kind = false,    --show all symbol kinds

            --visuals and behavior
            show_guides = true,                         --show hierarchy guides
            highlight_on_hover = true,                  --highlight code when hovering in Aerial
            highlight_on_jump = 210,                    --keep highlight for 210 ms after jumping
            open_automatic = false,                     --don’t open automatically
            close_on_select = true,                     --close Aerial when selecting a symbol
            close_automatic_events = { "unsupported" }, --close on unsupported file types

            --update behavior
            update_events = "TextChanged,InsertLeave",  --refresh symbols after editing
            treesitter = { update_delay = 210 },        --delay updates for performance

            --LSP-specific settings
            lsp = {
                diagnostics_trigger_update = true, --update when diagnostics change
                update_when_errors = true,         --keep updating even if LSP reports errors
                update_delay = 210,                --delay before updating symbols
            },
        })
    end,
}
