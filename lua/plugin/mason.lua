--LSP (Language Server Protocol) installer
return {
    { --download & install LSP servers, linters, formatters
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    { --bridge mason and nvim-lspconfig
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    --programming languages
                    "clangd",  --C/C++
                    "jdtls",   --Java
                    "pyright", --Python
                    "lua_ls",  --Lua

                    --web development
                    "html",  --HTML
                    "cssls", --CSS, SCSS
                    "ts_ls", --JavaScript, TypeScript, JSX, TSX
                    "vuels", --Vue

                    --data/config
                    "lemminx", --XML
                    "yamlls",  --YAML
                    "sqlls",   --SQL

                    --documentation
                    "marksman", --Markdown
                    "texlab",   --LaTeX
                }
            }
        end
    },
    { --predefine configs for servers
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason-lspconfig.nvim"
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local servers = {
                "clangd", "jdtls", "pyright", "lua_ls",
                "html", "cssls", "ts_ls", "vuels",
                "lemminx", "yamlls", "sqlls",
                "marksman", "texlab",
            }

            for _, server in ipairs(servers) do
                vim.lsp.config [server] = {
                    cmd = vim.lsp.rpc.connect(vim.fn.exepath(server)),
                    capabilities = capabilities
                }
                vim.lsp.enable(server)
            end

            local keymap = vim.keymap.set
            local lsp = vim.lsp.buf

            local set_hl = vim.api.nvim_set_hl
            --define custom highlight groups with colors
            set_hl(0,   "DiagnosticVirtualTextError",   {fg = "#e06c75"})
            set_hl(0,   "DiagnosticVirtualTextWarn",    {fg = "#e5c07b"})
            set_hl(0,   "DiagnosticVirtualTextHint",    {fg = "#00ffff"})
            set_hl(0,   "DiagnosticVirtualTextInfo",    {fg = "#abb2bf"})

            --sign colors at the beginning of line
            set_hl(0,   "DiagnosticSignError",          {fg = "#e06c75"})
            set_hl(0,   "DiagnosticSignWarn",           {fg = "#e5c07b"})
            set_hl(0,   "DiagnosticSignHint",           {fg = "#00ffff"})
            set_hl(0,   "DiagnosticSignInfo",           {fg = "#abb2bf"})

            --configure diagnostic display
            vim.diagnostic.config {
                virtual_text = {
                    enabled = true,
                    prefix = "",    --icon shown in inline message
                    spacing = 4,
                    source = false, --hide source prefix
                    format = function(diagnostic)
                        --add icon based on severity
                        local icon = ""
                        if diagnostic.severity == vim.diagnostic.severity.ERROR then
                            icon = ""
                        elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                            icon = ""
                        elseif diagnostic.severity == vim.diagnostic.severity.HINT then
                            icon = "󰰂"
                        elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                            icon = ""
                        end
                        return string.format("%s %s", icon, diagnostic.message)
                    end,
                },
                signs = true,
                underline = true,
                update_in_insert = false, --don't update diagnostics while typing
                severity_sort = true,     --sort by severity
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            }

            --configure diagnostic signs in the gutter at beginning of line
            local signs = {
                Error = "",
                Warn = "",
                Hint = "󰰂",
                Info = "",
            }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(
                    hl, {
                        text = icon,
                        texthl = hl,
                        numhl = ""
                    }
                )
            end

            --attach keymaps
            keymap(
                "n",
                "<leader>h",
                lsp.hover, {
                    noremap = true,
                    silent = true,
                    desc = "show hover info"
                }
            )
            keymap(
                "n",
                "<leader>d",
                lsp.definition, {
                    noremap = true,
                    silent = true,
                    desc = "show definition"
                }
            )
            keymap(
                {"n", "v"},
                "<leader>a",
                lsp.code_action, {
                    noremap = true,
                    silent = true,
                    desc = "show code action"
                }
            )
            keymap(
                "n",
                "[d",
                vim.diagnostic.goto_prev, {
                    noremap = true,
                    silent = true,
                    desc = "previous diagnostic"
                }
            )
            keymap(
                "n",
                "]d",
                vim.diagnostic.goto_next, {
                    noremap = true,
                    silent = true,
                    desc = "next diagnostic"
                }
            )
        end
    }
}
