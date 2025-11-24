return {
    --inline markdown previewer
    {
        "MeanderingProgrammer/render-markdown.nvim",
        event = "VeryLazy",
        ft = { "markdown" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            {
                "<leader>v",
                "<cmd>RenderMarkdown toggle<cr>",
                desc = "toggle inline markdown preview",
                mode = "n",
            },
        },
    },
    --browser markdown previewer
    {
        "iamcco/markdown-preview.nvim",
        event = "VeryLazy",
        ft = { "markdown" },
        cmd = {
            "MarkdownPreviewToggle",
            "MarkdownPreview",
            "MarkdownPreviewStop",
        },
        build = "cd app && npm install",
        init = function() vim.g.mkdp_filetypes = { "markdown" } end,
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
