return {
    --LSP server installer
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            --list of LSP servers for mason to install
            ensure_installed = {
                --LSP servers
                "clangd", --C/C++
                "jdtls", --Java
                "pyright", --Python
                "lua-language-server", --Lua
                "html-lsp", --HTML
                "css-lsp", --CSS, SCSS, LESS
                "vue-language-server", --Vue
                "typescript-language-server", --JavaScript, TypeScript, JSX, TSX
                "vtsls", --for typescript extension for vue, etc
                "json-lsp", --JSON
                "lemminx", --XML
                "yaml-language-server", --YAML
                "sqlls", --SQL
                "marksman", --Markdown
                "texlab", --LaTeX

                --formatters
                "clang-format", --format C, C++, Java
                "prettier", --for web
                "stylua", --for lua
            },
            ui = {
                icons = {
                    package_installed = "",
                    package_pending = "󱑤",
                    package_uninstalled = "",
                },
            },
        },
    },

    --LSP configurations
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrshh7th/cmp-nvim-lsp",
            "antosha417/nvim-lsp-file-operations",
        },
        config = function()
            --typescript extension configurations
            local vue_plugin_path = vim.fn.stdpath("data")
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
            local ts_filetypes = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
            }
            local vue_plugin = {
                name = "@vue/typescript-plugin",
                location = vue_plugin_path,
                languages = { "vue" },
                configNamespace = "typescript",
            }
            vim.lsp.config("vtsls", {
                filetypes = ts_filetypes,
                settings = {
                    vtsls = {
                        tsserver = { globalPlugins = { vue_plugin } },
                    },
                },
            })

            vim.lsp.enable("vtsls")

            --enable servers
            local servers = {
                "clangd",
                "jdtls",
                "pyright",
                "lua_ls",
                "html",
                "cssls",
                "jsonls",
                "vue_ls",
                "lemminx",
                "yamlls",
                "sqlls",
                "marksman",
                "texlab",
            }

            for _, server in ipairs(servers) do
                vim.lsp.enable(server)
            end

            vim.diagnostic.config({
                virtual_text = false, --handled by tiny-inline-diagnostic
                update_in_insert = false,
                signs = true,
            })

            --keymaps
            local set = function(mode, key, action, description)
                vim.keymap.set(mode, key, action, { noremap = true, silent = true, desc = description })
            end

            set("n", "gd", vim.lsp.buf.definition, "go to definition")
            set("n", "gD", vim.lsp.buf.declaration, "go to declaration")
            set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "select code action")
            set("n", "gr", vim.lsp.buf.rename, "rename symbol")

            --change line diagnostic icons
            local severity = vim.diagnostic.severity
            vim.diagnostic.config({
                signs = {
                    text = {
                        [severity.ERROR] = "󰅙",
                        [severity.WARN] = "",
                        [severity.HINT] = "󰌵",
                        [severity.INFO] = "",
                    },
                },
            })

            --LSP highlight groups
            local highlight = function(name, foreground)
                vim.api.nvim_set_hl(0, name, { fg = foreground, bg = "NONE", bold = true })
            end

            highlight("DiagnosticError", "#e06c75")
            highlight("DiagnosticWarn", "#e5c07b")
            highlight("DiagnosticHint", "#645394")
            highlight("DiagnosticInfo", "#028a0f")
        end,
    },
}
