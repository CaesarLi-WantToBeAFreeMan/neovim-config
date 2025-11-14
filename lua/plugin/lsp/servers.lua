return{
    "hrsh7th/cmp-nvim-lsp",
    event = "VeryLazy",
    dependencies = {
        {"antosha417/nvim-lsp-file-operations", config = true},
        {"folke/lazydev.nvim", opts = {}}
    },
    config = function()
        vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities()
        })
    end
}
