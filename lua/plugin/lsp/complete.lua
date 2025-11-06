return{
    "hrsh7th/nvim-cmp",                             --completion engine
    event = "InsertEnter",                          --call when entering insert mode
    dependencies = {
        "hrsh7th/cmp-buffer",                       --buffer text source
        "hrsh7th/cmp-path",                         --file system path source
        {
            "L3MON4D3/LuaSnip",                     --define, expand and jump through code snippets
            version = "v2.*",
            build = "make install_jsregexp"
        },
        "saadparwaiz1/cmp_luasnip",                 --lua snippt
        "rafamadriz/friendly-snippets",             --useful snippets
        "onsails/lspkind.nvim"                      --Microsoft Visual Studio Code like pictograms
    },
    config = function()
        local cmp, luasnip, lspkind = require("cmp"),  require("luasnip"), require("lspkind")

        --load Microsoft Visual Studio Code like snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {                                                 --how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-i>"] = cmp.mapping.complete(),                     --trigger completion
                ["<CR>"] = cmp.mapping.confirm({select = true}),        --confirm selection
                ["<C-e>"] = cmp.mapping.abort(),                        --close completion window
                ["<C-j>"] = cmp.mapping.select_next_item(),             --select next item
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),             --select previous item
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-f>"] = cmp.mapping.scroll_docs(10),                --scroll up 10 items
                ["<C-b>"] = cmp.mapping.scroll_docs(-10),               --scroll down 10 items
                ["<C-d>"] = cmp.mapping.scroll_docs(5),                 --scroll up 10 items
                ["<C-u>"] = cmp.mapping.scroll_docs(-5)                 --scroll down 10 items
            }),
            sources = cmp.config.sources({
                {name = "nvim_lsp"},                                    --LSP symbols
                {name = "luasnip"},                                     --snippets
                {name = "buffer"},                                      --text within current buffer
                {name = "path"}                                         --file system path
            }),
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsts_char = "..."
                })
            }
        })
    end
}
