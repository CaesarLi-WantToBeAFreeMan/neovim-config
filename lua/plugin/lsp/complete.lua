return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-signature-help", --function signature as completion source
            "onsails/lspkind.nvim",
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                dependencies = {
                    "rafamadriz/friendly-snippets", --Microsoft Visual Studio Code-style snippet collection
                },
            },
            "roginfarrer/cmp-css-variables", --complete CSS variables
            {
                "windwp/nvim-autopairs", --auto-insert () for functions/methods
                event = "InsertEnter",
                opts = {
                    check_ts = true, --use treesitter to avoid pairing inside strings/comments
                    ts_config = {
                        lua = { "string" },
                        javascript = { "string", "template_string" },
                        typescript = { "string", "template_string" },
                        java = false, --jdtls handles
                    },
                    fast_wrap = {
                        map = "<A-w>", --wrap the next word/token in a pair
                    },
                },
            },
        },
        config = function()
            local cmp, lspkind, luasnip = require("cmp"), require("lspkind"), require("luasnip")

            --load Microsoft Visual Studio Code-style snippets from friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()

            --after confirming a completion, auto-insert () for functions/methods
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            -- cyberpunk border characters
            local border = function(hl_name)
                return {
                    { "╭", hl_name },
                    { "─", hl_name },
                    { "╮", hl_name },
                    { "│", hl_name },
                    { "╯", hl_name },
                    { "─", hl_name },
                    { "╰", hl_name },
                    { "│", hl_name },
                }
            end

            cmp.setup({
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "nvim_lsp_signature_help", priority = 900 },
                    { name = "luasnip", priority = 800 },
                    { name = "css_variables", priority = 700 },
                    { name = "path", priority = 600 },
                    { name = "buffer", priority = 500, keyword_length = 3 },
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        before = function(entry, vim_item)
                            local labels = {
                                nvim_lsp = "[LSP]",
                                nvim_lsp_signature_help = "[Help]",
                                luasnip = "[Snip]",
                                buffer = "[Buf]",
                                path = "[Path]",
                                ["css-variables"] = "[CSS]",
                                cmdline = "[CMD]",
                            }
                            vim_item.menu = labels[entry.source.name] or "[?]"
                            vim_item.menu_hl_group = "CmpItemMenu"
                            return vim_item
                        end,
                    }),
                },
                window = {
                    completion = {
                        border = border("CmpBorder"),
                        winhighlight = table.concat({
                            "Normal:CmpNormalFloat", --popup bg
                            "CursorLine:CmpSel", --selected item
                            "Search:None", --no search highlight inside popup
                        }, ","),
                        scrollbar = true,
                        col_offset = -3, --shift left to align icon with border
                        side_padding = 1,
                    },
                    documentation = {
                        border = border("CmpDocBorder"),
                        winhighlight = "Normal:CmpNormalFloat,FloatBorder:CmpDocBorder",
                        max_width = 70,
                        max_height = 30,
                    },
                },
                experimental = {
                    ghost_text = { hl_group = "CmpGhostText" }, --preview first completion inline
                },
            })

            --search and command-line completion
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "buffer" } },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
            })
        end,
    },
    {
        "luckasRanarison/tailwind-tools.nvim",
        name = "tailwind-tools",
        build = ":UpdateRemotePlugins",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            server = {
                override = false, --don't call lspconfig
            },
            document_color = {
                enabled = true, --show color swatches inline next to class names
                kind = "inline", --"inline" | "foreground" | "background"
                debounce = 200,
            },
            conceal = {
                enabled = false, --don't hide long class strings
            },
        },
    },
}
