return{
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
        {
            "<F2>",
            "<cmd>Trouble symbols toggle focus=true<cr>",
            desc = "toggle symbols"
        },
        {
            "<S-F2>",
            "<cmd>Trouble lsp toggle focus=true<cr>",
            desc = "toggle LSP definitions/references..."
        },
        {
            "<C-F2>",
            "<cmd>Trouble diagnostics toggle focus=true<cr>",
            desc = "toggle buffer LSP diagnostics"
        }
    },
    opts = {
        use_diagnostic_signs = true,
        auto_preview = false,
        auto_close = true,
        focus = true,
        win = {
            type = "split",
            position = "right",
            size = 100
        },
        keys = {
            ["<cr>"] = "jump_close",
            ["<2-leftmouse>"] = false,
            ["<leftmouse>"] = false,
            ["d"] = "delete",
            ["dd"] = false,
            ["<c-s>"] = false,
            ["h"] = "jump_split",
            ["<c-v>"] = false,
            ["v"] = "jump_vsplit",
            ["}"] = false,
            ["]]"] = false,
            ["{"] = false,
            ["[["] = false,
            ["o"] = "fold_open",
            ["O"] = "fold_open_recursive",
            ["c"] = "fold_close",
            ["C"] = "fold_close_recursive",
            ["x"] = "fold_toggle",
            ["X"] = "fold_toggle_recursive"
        },
        action_keys = {
            jump_split_close = {

            }
        },
        modes = {
            preview_float = {
                mode = "diagnostics",
                preview = {
                    type = "float",
                    relative = "editor",
                    border = "rounded",
                    title = "Trouble Preview",
                    title_pos = "center",
                    position = {0, -2},
                    size = {width = 0.3, height = 0.3},
                    zindex = 210
                }
            }
        }
    }
}
