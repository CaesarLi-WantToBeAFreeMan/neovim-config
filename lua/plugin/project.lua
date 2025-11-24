return {
    "folke/persistence.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
        vim.keymap.set(
            "n",
            "<leader>fs",
            function() require("persistence").select() end,
            { desc = "find sessions (projects)" }
        )
        require("persistence").setup({})
    end,
}
