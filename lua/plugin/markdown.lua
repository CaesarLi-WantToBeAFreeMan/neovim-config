return {
    --inline markdown previewer
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            render_modes = { "n", "c" }, --render in normal and command mode only
            heading = {
                enabled = true,
                sign = false, --don't use sign column for heading icons
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            },
            code = {
                enabled = true,
                sign = false,
                style = "full",
                border = "thick",
                above = "󱔓",
                below = "󱂩",
            },
            bullet = { enabled = true },
            checkbox = {
                enabled = true,
                unchecked = { icon = "󰄰" },
                checked = { icon = "󰄴" },
            },
            table = { enabled = true },
            quote = { enabled = true },
            link = { enabled = true },
        },
        keys = {
            { "<leader>v", "<cmd>RenderMarkdown toggle<cr>", mode = "n", desc = "toggle inline markdown preview" },
        },
    },
    --browser markdown previewer
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        cmd = {
            "MarkdownPreviewToggle",
            "MarkdownPreview",
            "MarkdownPreviewStop",
        },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_auto_close = 1 --close preview when buffer closes
            vim.g.mkdp_combine_preview = 1 --reuse existing preview tab
            vim.g.mkdp_theme = "dark"
        end,
        keys = {
            {
                "<leader>V",
                "<cmd>MarkdownPreviewToggle<cr>",
                desc = "toggle browser markdown preview",
                mode = "n",
            },
        },
    },
}
