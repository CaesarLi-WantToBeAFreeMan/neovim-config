return{
    "hrsh7th/nvim-cmp",--completion engine
    dependencies = {
        "hrsh7th/vim-vsnip",            --snippet engine
        "hrsh7th/cmp-vsnip",            --VSnip completion source
        "hrsh7th/cmp-nvim-lsp",         --LSP completion source
        "hrsh7th/cmp-buffer",           --buffer completion source
        "hrsh7th/cmp-path",             --path completion source
        "rafamadriz/friendly-snippets"  --snippet collection
    },
    config = function()
        local cmp = require("cmp")

        --set snippet directory
        local snippet_dir = vim.fn.has("win32") == 1
                            and vim.fn.expand("~/AppData/Local/nvim/snippets")  --Microsoft Windows snippet directory
                            or vim.fn.expand("~/.config/nvim/snippets")         --snippet directory of Unix-like OS
        vim.g.vsnip_snippet_dir = snippet_dir                                   --define custom snippet directory

        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn ["vsnip#anonymous"](args.body)                       --use VSnip for snippet expansion
                end
            },
            window = {
                completion = cmp.config.window.bordered(),          --use bordered completion menu
                documentation = cmp.config.window.bordered()        --use bordered documentation window
            },
            mapping = {
                --navigation
                ["<C-k>"] = cmp.mapping.select_prev_item(),         --select previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(),         --select next suggestion

                --scrolling
                ["<C-b>"] = cmp.mapping.scroll_docs(-5),            --scroll documentation up
                ["<C-f>"] = cmp.mapping.scroll_docs(5),             --scroll documentation down

                --confirm selection
                ["<CR>"] = cmp.mapping.confirm({select = false}),   --confirm selection without auto-selecting

                --navigate or expand
                ["<Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()                  --select next item if completion menu is visible
                        elseif vim.fn ["vsnip#available"](1) == 1 then
                            vim.fn.feedkeys(                        --expand or jump to next snippet placeholder
                                vim.api.nvim_replace_termcodes(
                                    "<Plug>(vsnip_exapnd-or-jump)",
                                    true,
                                    true,
                                    true
                                ),
                                ""
                            )
                        else
                            fallback()                              --default tab behavior that inserts a tab
                        end
                    end,
                    {"i", "s"}
                ),

                ["<S-Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()                  --select previous item if completion menu is visible
                        elseif vim.fn ["vsnip#jumpable"](-1) == 1 then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes(     --jump to previous snippet placeholder
                                    "<Plug>(vsnip-jump-prev)",
                                        true,
                                        true,
                                        true
                                ),
                                ""
                            )
                        else
                            fallback()                              --default <S-Tab> behavior
                        end
                    end,
                    {"i", "s"}
                )
            },
            sources = cmp.config.sources({
                {name = "nvim_lsp"},                                --LSP completion source
                {name = "vsnip"},                                   --snippet completion source
                {name = "buffer"},                                  --buffer text completion source
                {name = "path"}                                     --file path completion source
            })
        })
    end
}
