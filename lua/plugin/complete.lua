return{
    "hrsh7th/nvim-cmp",--completion engine
    dependencies = {
        --snippet engine
        "hrsh7th/vim-vsnip",
        "hrsh7th/cmp-vsnip",

        --completion sources
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",

        --snippet collection
        "rafamadriz/friendly-snippets"
    },
    config = function()
        local cmp = require("cmp")

        --load snippets
        vim.cmd([[let g:vsnip_snippet_dir = expand('~/AppData/Local/nvim/snippets')]])

        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn ["vsnip#anonymous"](args.body)--use vsnip (VSCode snippet feature) as snippet engine
                end,
            },
            window = {--use beautiful window
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                --navigation
                ["<C-k>"] = cmp.mapping.select_prev_item(),--previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(),--next suggestion

                --scrolling
                ["<C-b>"] = cmp.mapping.scroll_docs(-5),--scroll up
                ["<C-f>"] = cmp.mapping.scroll_docs(5),--scroll down

                --confirm selection
                ["<CR>"] = cmp.mapping.confirm({select = false}),--accept currently selected item

                --navigate or expand
                ["<Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.fn ["vsnip#available"](1) == 1 then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes(
                                    "<Plug>(vsnip_exapnd-or-jump)",
                                    true,
                                    true,
                                    true
                                ),
                                ""
                            )
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                ),

                ["<S-Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.fn ["vsnip#jumpable"](-1) == 1 then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes(
                                    "<Plug>(vsnip-jump-prev)",
                                        true,
                                        true,
                                        true
                                ),
                                ""
                            )
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                ),
            }),
            sources = cmp.config.sources({--snippets sources
                {name = "nvim_lsp"},
                {name = "vsnip"},
                {name = "buffer"},
                {name = "path"}
            })
        })
    end
}
