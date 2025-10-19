return {
    {
        "williamboman/mason.nvim",          --LSP, linter and formatter installer
        config = function()
            require("mason").setup()        --initialize mason with default settings
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",--bridge mason and nvim-lspconfig
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    --programming languages
                    --C++,      Java,       Python,     Lua
                    "clangd",   "jdtls",    "pyright", "lua_ls",
                    --web development
                    --HTML, CSS/SCSS,   JS/TS/JSX/TSX,  Vue
                    "html", "cssls",    "ts_ls",        "vuels",
                    --data/config
                    --XML,      YAML,       SQL
                    "lemminx", "yamlls",    "sqlls",
                    --documentation
                    --Markdown, LaTeX
                    "marksman", "texlab"
                }
            })                              --install specific LSP servers
        end
    },
    {
        "neovim/nvim-lspconfig",            --LSP configurations
        dependencies = {
            "hrsh7th/cmp-nvim-lsp"          --LSP completion integration
        },
        config = function()
            --enable LSP completion capabilities
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local servers = {
                "clangd", "jdtls", "pyright", "lua_ls",
                "html", "cssls", "ts_ls", "vuels",
                "lemminx", "yamlls", "sqlls",
                "marksman", "texlab",
            }

            for _, server in ipairs(servers) do
                require("lspconfig") [server].setup({
                    capabilities = capabilities
                })
            end

            -- ============ diagnostic text colors ============
            vim.api.nvim_set_hl(0,  "DiagnosticVirtualTextError",   {fg = "#e06c75"})
            vim.api.nvim_set_hl(0,  "DiagnosticVirtualTextWarn",    {fg = "#e5c07b"})
            vim.api.nvim_set_hl(0,  "DiagnosticVirtualTextHint",    {fg = "#00ffff"})
            vim.api.nvim_set_hl(0,  "DiagnosticVirtualTextInfo",    {fg = "#abb2bf"})

            -- ============ sign colors ============
            vim.api.nvim_set_hl(0,  "DiagnosticSignError",          {fg = "#e06c75"})
            vim.api.nvim_set_hl(0,  "DiagnosticSignWarn",           {fg = "#e5c07b"})
            vim.api.nvim_set_hl(0,  "DiagnosticSignHint",           {fg = "#00ffff"})
            vim.api.nvim_set_hl(0,  "DiagnosticSignInfo",           {fg = "#abb2bf"})

            --diagnostic configuration
            vim.diagnostic.config({
                virtual_text = false,               --disable inline diagnostic text
                signs = true,                       --show diagnostic signs in gutter
                underline = true,                   --underline diagnostic issues
                update_in_insert = false,           --delay updates during insert mode
                severity_sort = true,               --sort diagnostics by severity
                float = {                           --use rounded borders for floating diagnostics
                    border = "rounded",
                    style = "minimal",
                    source = "always"
                }
            })

            --single inline diagnostic per line
            vim.api.nvim_create_autocmd("DiagnosticChanged", {
                callback = function()
                    --create namespace for diagnostics
                    local ns = vim.b.inline_ns or vim.api.nvim_create_namespace("inline_diag")
                    vim.b.inline_ns = ns
                    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)--clear previous diagnostics

                    local diags = vim.diagnostic.get(0)
                    local shown = {}

                    for _, d in ipairs(diags) do
                        if not shown [d.lnum] then
                            local icons = {     --diagnostic icons
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

                            vim.api.nvim_buf_set_extmark(0, ns, d.lnum, 0, {
                                virt_text = {
                                    --display diagnostic with icon
                                    {" " .. (icons [d.severity] or "") .. " " .. d.message, hl_map [d.severity]}
                                },
                                virt_text_pos = "eol",
                            })
                            shown [d.lnum] = true--mark line as shown
                        end
                    end
                end
            })

            --gutter signs
            local signs = {--define diagnostic sign icons
                Error = "",
                Warn = "",
                Hint = "󰰂",
                Info = "",
            }

            for type, icon in pairs(signs) do
                vim.fn.sign_define(
                    "diagnosticSign" .. type, {
                    text = icon,
                    texthl = "DiagnosticSign" .. type
                })
            end

            --LSP keymaps
            vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {
                silent = true,
                desc = "show hover info"
            })
            vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, {
                silent = true,
                desc = "show definition"
            })
            vim.keymap.set({"n", "v"}, "<leader>a", vim.lsp.buf.code_action, {
                silent = true,
                desc = "show code actions"
            })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
                silent = true,
                desc = "previous diagnostic"
            })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
                silent = true,
                desc = "next diagnostic"
            })
        end
    }
}
