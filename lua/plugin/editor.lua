return {
    --search/replace across files
    {
        "MagicDuck/grug-far.nvim",
        cmd = { "GrugFar", "GrugFarWithin" },
        opts = {
            headerMaxWidth = 90,
        },
        keys = {
            {
                "<leader>sr", --search and replace
                function()
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    require("grug-far").open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and ("*." .. ext) or nil,
                        },
                    })
                end,
                mode = { "n", "x" },
                desc = "search & replace for all same filetype files",
            },
            {
                "<leader>sR",
                function() require("grug-far").open({ transient = true }) end,
                mode = { "n", "x" },
                desc = "search & replace for all files",
            },
            {
                "<leader>sw",
                function()
                    require("grug-far").open({
                        transient = true,
                        prefills = { search = vim.fn.expand("<cword>") },
                    })
                end,
                mode = "n",
                desc = "search & replace word under cursor",
            },
        },
    },
    --HTTP client
    --send HTTP requests inside *.http files
    {
        "mistweaverco/kulala.nvim",
        ft = { "http", "rest" },
        opts = {
            default_view = "body",
            default_env = "dev",
            debug = false,
            vscode_rest_client_environmentvars = true,
        },
        keys = {
            { "<leader>hr", function() require("kulala").run() end, mode = "n", desc = "run HTTP request" },
            {
                "<leader>hR",
                function() require("kulala").run_all() end,
                mode = "n",
                desc = "run all HTTP requests",
            },
            {
                "<leader>hl",
                function() require("kulala").replay() end,
                mode = "n",
                desc = "replay last HTTP request",
            },
            {
                "<leader>hi",
                function() require("kulala").inspect() end,
                mode = "n",
                desc = "inspect HTTP request",
            },
            { "<leader>hy", function() require("kulala").copy() end, mode = "n", desc = "yank as curl" },
            {
                "<leader>he",
                function() require("kulala").set_selected_env() end,
                mode = "n",
                desc = "select environment",
            },
            { "]H", function() require("kulala").jump_next() end, mode = "n", desc = "next HTTP request" },
            { "[H", function() require("kulala").jump_prev() end, mode = "n", desc = "prev HTTP request" },
        },
    },
    --database client
    --write queries for MySQL, PostgreSQL, Redis, etc
    {
        "kndndrj/nvim-dbee",
        dependencies = { "MunifTanjim/nui.nvim" },
        build = function() require("dbee").install() end,
        cmd = "Dbee",
        keys = {
            { "<leader>DB", function() require("dbee").toggle() end, mode = "n", desc = "toggle DB client" },
        },
    },
    --git differences viewer
    --full-screen diff view, file history, and merge conflict resolution
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
        opts = {
            enhanced_diff_hl = true,
            view = {
                default = { layout = "diff2_horizontal" },
                merge_tool = { layout = "diff3_horizontal" },
                file_history = { layout = "diff2_horizontal" },
            },
        },
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<CR>", mode = "n", desc = "open diff view" },
            { "<leader>gD", "<cmd>DiffviewClose<CR>", mode = "n", desc = "close diff view" },
            { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", mode = "n", desc = "file git history" },
            { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", mode = "n", desc = "branch git history" },
        },
    },
}
