--a fuzzy finder
return {
    {
        "nvim-telescope/telescope.nvim", --fuzzy finder
        tag = "0.1.8", --stable version
        event = "VeryLazy",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        --[[
        keys = {
            --files
            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "find files", mode = "n" },
            { "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "find text ", mode = "n" },
            { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "find recent files", mode = "n" },

            --vim
            { "<leader>fc", "<cmd>Telescope commands<CR>", desc = "find commands", mode = "n" },
            { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "find keymaps", mode = "n" },
            { "<leader>fl", "<cmd>Telescope loclist<CR>", desc = "find location list", mode = "n" },
            { "<leader>fj", "<cmd>Telescope jumplist<CR>", desc = "find jump list", mode = "n" },
            { "<leader>fm", "<cmd>Telescope marks<CR>", desc = "find marks", mode = "n" },
            { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "find git status", mode = "n" },
        },
        ]]
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            --complete tag
                            ["<Tab>"] = actions.complete_tag,
                            ["<C-l>"] = false,

                            --movements
                            ["<Up>"] = false,
                            ["<Down>"] = false,

                            --preview
                            ["<C-k>"] = actions.preview_scrolling_up,
                            ["<C-u>"] = false,
                            ["<PageUp>"] = false,
                            ["<C-j>"] = actions.preview_scrolling_down,
                            ["<C-d>"] = false,
                            ["<PageDown>"] = false,

                            --selections
                            ["<C-h>"] = actions.select_horizontal,
                            ["<C-X>"] = false,
                        },

                        --normal mode
                        n = {
                            --movements
                            ["<Up>"] = false,
                            ["<Down>"] = false,
                            ["L"] = false,
                            ["T"] = false,
                            ["H"] = false,

                            --preview
                            ["<C-k>"] = actions.preview_scrolling_up,
                            ["<C-u>"] = false,
                            ["<PageUp>"] = false,
                            ["<C-j>"] = actions.preview_scrolling_down,
                            ["<C-d>"] = false,
                            ["<PageDown>"] = false,

                            --selections
                            ["<C-h>"] = actions.select_horizontal,
                            ["<C-X>"] = false,
                        },
                    },
                },
                pickers = {
                    buffers = {
                        initial_mode = "normal", --start buffer picker in normal mode
                        mappings = {
                            i = {
                                ["<C-d>"] = actions.delete_buffer,
                                ["<leader>d"] = actions.delete_buffer,
                            },
                            n = {
                                ["dd"] = actions.delete_buffer,
                                ["D"] = actions.delete_buffer,
                            },
                        },
                    },
                },
            })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim", --dropdown UI extension
        event = "VeryLazy",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = require("telescope.themes").get_dropdown(),
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
