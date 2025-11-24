return {
    "hrsh7th/nvim-cmp", --completion engine
    event = "VeryLazy",
    dependencies = {
        "hrsh7th/cmp-buffer", --buffer text source
        "hrsh7th/cmp-path", --file system path source
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-cmdline",
        "onsails/lspkind.nvim", --Microsoft Visual Studio Code like pictograms
        {
            "L3MON4D3/LuaSnip", --define, expand and jump through code snippets
            version = "v2.*",
            build = "make install_jsregexp",
        },
    },
    config = function()
        local cmp, lspkind = require("cmp"), require("lspkind")

        --load Microsoft Visual Studio Code like snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args) require("luasnip").lsp_expand(args.body) end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({ select = true }), --confirm selection
                ["<C-e>"] = cmp.mapping.abort(), --close completion window
                ["<C-k>"] = cmp.mapping.select_prev_item(), --select previous item
                ["<C-j>"] = cmp.mapping.select_next_item(), --select next item
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" }, --LSP symbols
                { name = "luasnip" }, --snippets
                { name = "buffer" }, --text within current buffer
                { name = "path" }, --file system path
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = "text",
                    maxwidth = 50,
                }),
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        })

        cmp.setup.cmdline({ ":", "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
        })
    end,
}
