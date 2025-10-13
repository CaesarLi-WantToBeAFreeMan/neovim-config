--a fuzzy finder
return{
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",--stable version
    dependencies = {
        "nvim-lua/plenary.nvim",--required dependency
    },

    --custom keymaps
    keys = {
        --files
        {"<leader>ff", "<cmd>Telescope find_files<CR>", desc = "find files"},
        {"<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "find text inside project files"},
        {"<leader>fb", "<cmd>Telescope buffers<CR>", desc = "find buffers"},
        {"<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "find recent files"},
        {"<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "find word under cursor"},

        --vim
        {"<leader>fc", "<cmd>Telescope commands<CR>", desc = "find commands"},
        {"<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "find keymaps"},
        {"<leader>fl", "<cmd>Telescope loclist<CR>", desc = "find location list"},
        {"<leader>fj", "<cmd>Telescope jumplist<CR>", desc = "find jump list"},
        {"<leader>fm", "<cmd>Telescope marks<CR>", desc = "find marks"},
        {"<leader>ft", "<cmd>Telescope tags<CR>", desc = "find tags"},

        --git
        {"<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "find git commits"},
        {"<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "find git branches"},
        {"<leader>gs", "<cmd>Telescope git_status<CR>", desc = "find git status"},
    },

    --custom configuration
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                mappings = {
                    --insert mode
                    i = {
                        ["<C-j>"] = actions.move_selection_next,--like <C-n>
                        ["<C-k>"] = actions.move_selection_previous,--like <C-p>
                        --default is open in the window
                        ["<CR>"] = actions.select_vertical,
                        ["<leader>h"] = actions.select_horizontal,--like <C-x>
                        ["<leader>v"] = actions.select_vertical,
                        ["<leader>t"] = actions.select_tab,--like <C-t>
                    },

                    --normal mode
                    n = {
                        ["CR"] = actions.select_vertical,--like in insert mode
                        ["<leader>h"] = actions.select_horizontal,--like in insert mode
                        ["<leader>v"] = actions.select_vertical,--like in insert mode
                        ["<leader>t"] = actions.select_tab,--like in insert mode

                        ["T"] = actions.move_to_top,--like H
                        ["C"] = actions.move_to_middle,--like M, from Center
                        ["B"] = actions.move_to_bottom,--like L
                    },
                },
            },

            pickers = {
                --find files configuration
                find_files = {
                    theme = "dropdown",--use dropdown theme
                    previewer = false,--disable preview
                    hidden = true,--show hidden files
                },

                --buffers configuration
                buffers = {
                    theme = "dropdown",
                    previewer = false,
                    initial_mode = "normal",--start in normal mode
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

                --old (recent) files
                oldfiles = {
                    theme = "dropdown",
                },

                --keymaps
                keymaps = {
                    theme = "dropdown",
                },

                --commands
                commands = {
                    theme = "dropdown",
                },
            },
        })
    end,
}
