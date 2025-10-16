--LSP (Language Server Protocol) installer
return {
    {--download & install LSP servers, linters, formatters
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {--bridge mason and nvim-lspconfig
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    --programming languages
                    --C++,      Java,       Python,     Lua
                    "clangd",   "jdtls",    "pyright", "lua_ls",
                    --web development
                    --HTML, CSS/SCSS,   JavaScript/TypeScript/JSX/TSX,  Vue
                    "html", "cssls",    "ts_ls",                        "vuels",
                    --data/config
                    --XML,      YAML,       SQL
                    "lemminx", "yamlls",    "sqlls",
                    --documentation
                    --Markdown, LaTeX
                    "marksman", "texlab",
                }
            }
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp"
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
                vim.lsp.config(server, {
                    capabilities = capabilities
                })
                vim.lsp.enable(server)
            end

            local keymap = vim.keymap.set
            local lsp = vim.lsp.buf
            local set_hl = vim.api.nvim_set_hl

            --define custom highlight groups with colors
            set_hl(0, "DiagnosticVirtualTextError", {fg = "#e06c75"})
            set_hl(0, "DiagnosticVirtualTextWarn", {fg = "#e5c07b"})
            set_hl(0, "DiagnosticVirtualTextHint", {fg = "#00ffff"})
            set_hl(0, "DiagnosticVirtualTextInfo", {fg = "#abb2bf"})

            --sign colors at the beginning of line
            set_hl(0, "DiagnosticSignError", {fg = "#e06c75"})
            set_hl(0, "DiagnosticSignWarn", {fg = "#e5c07b"})
            set_hl(0, "DiagnosticSignHint", {fg = "#00ffff"})
            set_hl(0, "DiagnosticSignInfo", {fg = "#abb2bf"})

            --disable built-in inline text
            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = ""
                }
            })

            --clear and redraw a single inline diagnostic per line
            vim.api.nvim_create_autocmd("DiagnosticChanged", {
                callback = function()
                    vim.b.inline_ns = vim.b.inline_ns or vim.api.nvim_create_namespace("inline_diag")
                    vim.api.nvim_buf_clear_namespace(0, vim.b.inline_ns, 0, -1)

                    local diags = vim.diagnostic.get(0)
                    local shown = {}

                    for _, d in ipairs(diags) do
                        local lnum = d.lnum
                        if not shown[lnum] then
                            local icons = {
                                [vim.diagnostic.severity.ERROR] = "",
                                [vim.diagnostic.severity.WARN] = "",
                                [vim.diagnostic.severity.HINT] = "󰰂",
                                [vim.diagnostic.severity.INFO] = "",
                            }

                            local hl_map = {
                                [vim.diagnostic.severity.ERROR] = "DiagnosticVirtualTextError",
                                [vim.diagnostic.severity.WARN] = "DiagnosticVirtualTextWarn",
                                [vim.diagnostic.severity.HINT] = "DiagnosticVirtualTextHint",
                                [vim.diagnostic.severity.INFO] = "DiagnosticVirtualTextInfo",
                            }

                            local icon = icons[d.severity] or ""
                            local hl = hl_map[d.severity] or "DiagnosticVirtualTextError"

                            vim.api.nvim_buf_set_extmark(0, vim.b.inline_ns, lnum, 0, {
                                virt_text = {
                                    {" " .. icon .. " " .. d.message, hl}
                                },
                                virt_text_pos = "eol",
                            })
                            shown[lnum] = true
                        end
                    end
                end
            })

            --gutter signs
            local signs = {
                Error = "",
                Warn = "",
                Hint = "󰰂",
                Info = "",
            }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, {
                    text = icon,
                    texthl = hl,
                    numhl = ""
                })
            end

            --LSP keymaps
            keymap("n", "<leader>h", lsp.hover, {
                noremap = true,
                silent = true,
                desc = "show hover info"
            })
            keymap("n", "<leader>d", lsp.definition, {
                noremap = true,
                silent = true,
                desc = "show definition"
            })
            keymap({"n", "v"}, "<leader>a", lsp.code_action, {
                noremap = true,
                silent = true,
                desc = "show code action"
            })
            keymap("n", "[d", vim.diagnostic.goto_prev, {
                noremap = true,
                silent = true,
                desc = "previous diagnostic"
            })
            keymap("n", "]d", vim.diagnostic.goto_next, {
                noremap = true,
                silent = true,
                desc = "next diagnostic"
            })
        end
    }
}
