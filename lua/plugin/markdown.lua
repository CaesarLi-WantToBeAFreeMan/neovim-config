return {
    --inline markdown previewer
    {
        "MeanderingProgrammer/render-markdown.nvim",
        event = "VeryLazy",
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
        cmd = {
            "MarkdownPreviewToggle",
            "MarkdownPreview",
            "MarkdownPreviewStop",
        },
        build = "cd app && npm install",
        init = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
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
