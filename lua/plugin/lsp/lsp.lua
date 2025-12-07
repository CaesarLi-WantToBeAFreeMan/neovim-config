return {
    --LSP server installer
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        event = "VeryLazy",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "",
                        package_pending = "󱑤",
                        package_uninstalled = "",
                    },
                },
                --automatically install via Mason
                ensure_installed = {
                    --LSP servers
                    --programming languages
                    "clangd", --C/C++
                    "jdtls", --Java
                    "pyright", --Python
                    "lua_ls", --Lua
                    --web development
                    "html", --HTML
                    "cssls", --CSS/SCSS/SASS/LESS
                    "emmet_ls", --Emmet snippets
                    "ts_ls", --JavaScript/TypeScript
                    "vtsls", --enhanced TypeScript for Vue
                    --configuration
                    "jsonls", --JSON
                    "yamlls", --YAML
                    "lemminx", --XML
                    "taplo", --TOML
                    "dockerls", --Docker
                    --documentation
                    "marksman", --Markdown
                    "texlab", --LaTeX

                    --formatters
                    "clang-format", --C/C++/Java formatter
                    "prettier", --HTML/CSS/SCSS/SASS/LESS/JavaScript/TypeScript/React/Vue/Markdown formatter
                    "sql-formatter", --SQL formatter
                    "stylua", --lua formatter
                },
            })
        end,
    },
    --bridge between mason and lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = {
            "neovim/nvim-lspconfig", --provide default configs for servers
        },
        config = function()
            require("mason-lspconfig").setup({
                --auto-enable servers
                automatic_enable = true,
                --override default config
                handlers = {
                    --Vue/TypeScript integration
                    ["vtsls"] = function()
                        local vue_plugin_path = vim.fn.stdpath("data")
                            .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
                        vim.lsp.config("vtsls", {
                            filetypes = {
                                "vue",
                                "javascript",
                                "javascriptreact",
                                "typescript",
                                "typescriptreact",
                            },
                            settings = {
                                vtsls = {
                                    tssercer = {
                                        globalPlugins = {
                                            {
                                                name = "@vue/typescript-plugin",
                                                location = vue_plugin_path,
                                                languages = { "vue" },
                                                configNamespace = "typescript",
                                            },
                                        },
                                    },
                                },
                            },
                        })
                        vim.lsp.enable("vtsls")
                    end,
                },
            })

            --beautiful LSP diagnostic icons and highlights
            local icons = {
                Error = "",
                Warn = "",
                Hint = "󰌵",
                Info = "",
            }

            for type, icon in pairs(icons) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, {
                    text = icon,
                    texthl = hl,
                    numhl = hl,
                })
            end

            local hl = function(name, highlight) vim.api.nvim_set_hl(0, name, highlight) end
            hl("DiagnosticError", { fg = "#e06c75" })
            hl("DiagnosticWarn", { fg = "#e5c07b" })
            hl("DiagnosticHint", { fg = "#645394" })
            hl("DiagnosticInfo", { fg = "#028a0f" })

            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                virtual_text = false, --use tiny-inline-diagnostic to display inline diagnostic
                signs = { active = true }, --use custom signs
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = true,
                    header = "",
                    prefix = "",
                },
            })

            --LSP keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf

                    local key = function(mode, key, action, description)
                        vim.keymap.set(mode, key, action, { buffer = bufnr, desc = "LSP: " .. description })
                    end

                    --navigation
                    key("n", "gd", vim.lsp.buf.definition, "go to definition")
                    key("n", "gD", vim.lsp.buf.declaration, "go to declaration")
                    key("n", "<leader>lr", vim.lsp.buf.rename, "rename symbol")
                    key({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "code action")

                    --diagnostic navigation
                    key(
                        "n",
                        "[d",
                        function() vim.diagnostic.jump({ count = -1, float = true }) end,
                        "previous diagnostic"
                    )
                    key("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "next diagnostic")
                    key(
                        "n",
                        "[e",
                        function()
                            vim.diagnostic.jump({
                                count = -1,
                                float = true,
                                severity = vim.diagnostic.severity.ERROR,
                            })
                        end,
                        "previous error"
                    )
                    key(
                        "n",
                        "]e",
                        function()
                            vim.diagnostic.jump({
                                count = 1,
                                float = true,
                                severity = vim.diagnostic.severity.ERROR,
                            })
                        end,
                        "next error"
                    )
                    key(
                        "n",
                        "[w",
                        function()
                            vim.diagnostic.jump({
                                count = -1,
                                float = true,
                                severity = vim.diagnostic.severity.WARN,
                            })
                        end,
                        "previous warning"
                    )
                    key(
                        "n",
                        "]w",
                        function()
                            vim.diagnostic.jump({
                                count = 1,
                                float = true,
                                severity = vim.diagnostic.severity.WARN,
                            })
                        end,
                        "next warning"
                    )
                    key(
                        "n",
                        "[h",
                        function()
                            vim.diagnostic.jump({
                                count = -1,
                                float = true,
                                severity = vim.diagnostic.severity.HINT,
                            })
                        end,
                        "previous hint"
                    )
                    key(
                        "n",
                        "]h",
                        function()
                            vim.diagnostic.jump({
                                count = 1,
                                float = true,
                                severity = vim.diagnostic.severity.HINT,
                            })
                        end,
                        "next hint"
                    )
                    key(
                        "n",
                        "[i",
                        function()
                            vim.diagnostic.jump({
                                count = -1,
                                float = true,
                                severity = vim.diagnostic.severity.INFO,
                            })
                        end,
                        "previous info"
                    )
                    key(
                        "n",
                        "]i",
                        function()
                            vim.diagnostic.jump({
                                count = 1,
                                float = true,
                                severity = vim.diagnostic.severity.INFO,
                            })
                        end,
                        "next info"
                    )
                end,
            })
        end,
    },
}
