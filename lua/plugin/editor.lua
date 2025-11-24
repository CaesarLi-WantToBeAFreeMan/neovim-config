return {
    --search/replace in multiple files
    {
        "MagicDuck/grug-far.nvim",
        event = "VeryLazy",
        opts = {
            headerMaxWidth = 90,
        },
        cmd = {
            "GrugFar",
            "GrugFarWithin",
        },
        keys = {
            {
                "<leader>sr", --search and replace
                function()
                    local grug, ext = require("grug-far"), vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefiles = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,
                mode = { "n", "x" },
                desc = "search and replace in multiple files",
            },
        },
    },
    --find and list all of the TODO
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        cmd = {
            "TodoTrouble",
            "TodoTelescope",
        },
        opts = {},
        keys = {
            {
                "[t",
                function() require("todo-comments").jump_prev() end,
                desc = "previous TODO comment",
            },
            {
                "]t",
                function() require("todo-comments").jump_next() end,
                desc = "next TODO comment",
            },
            {
                "<leader>tt",
                "<cmd>TodoTelescope<CR>",
                desc = "list TODO comments via telescope",
            },
            {
                "<leader>tT",
                "<cmd>Trouble todo toggle<CR>",
                desc = "list TODO comments via Trouble",
            },
        },
    },
}
