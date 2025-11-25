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
}
