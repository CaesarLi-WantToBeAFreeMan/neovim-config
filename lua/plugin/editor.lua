return{
    --search/replace in multiple files
    {
        "MagicDuck/grug-far.nvim",
        event = "VeryLazy",
        opts = {
            headerMaxWidth = 90
        },
        cmd = {
            "GrugFar",
            "GrugFarWithin"
        },
        keys = {
            {
                "<leader>sr",           --search and replace
                function()
                    local grug, ext = require("grug-far"), vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefiles = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil
                        }
                    })
                end,
                mode = {"n", "x"},
                desc = "search and replace in multiple files"
            }
        }
    },
    --enhance search functionality
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        vscode = true,
        opts = {},
        keys = {
            {
                "s",
                mode = {"n", "x", "o"},
                function()
                    require("flash").jump()
                end,
                desc = "flash"
            },
            {
                "S",
                mode = {"n", "o", "x"},
                function()
                    require("flash").treesitter()
                end,
                desc = "flash treesitter"
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "remote flash"
            },
            {
                "R",
                mode = {"o", "x"},
                function()
                    require("flash").treesitter_search()
                end,
                desc = "treesitter search"
            },
            {
                "<C-s>",
                mode = {"c"},
                function()
                    require("flash").toggle()
                end,
                desc = "toggle flash search"
            },
            {
                "<C-Space>",
                mode = {"n", "o", "x"},
                function()
                    require("flash").treesitter({
                        actions = {
                            ["<C-n>"] = "next",
                            ["<C-p>"] = "prev"
                        }
                    })
                end
            }
        }
    },
    --find and list all of the TODO
    {
        "folke/todo-comments.nvim",
        cmd = {
            "TodoTrouble",
            "TodoTelescope"
        },
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "[t",
                function()
                    require("todo-comments").jump_prev()
                end,
                desc = "previous TODO comment"
            },
            {
                "]t",
                function()
                    require("todo-comments").jump_next()
                end,
                desc = "next TODO comment"
            },
            {
                "<leader>tt",
                "<cmd>TodoTelescope<CR>",
                desc = "list TODO comments via telescope"
            },
            {
                "<leader>tT",
                "<cmd>Trouble todo toggle<CR>",
                desc = "list TODO comments via Trouble"
            }
        }
    }
}
