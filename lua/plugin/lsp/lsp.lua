return {
    --LSP server installer
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        opts = {
            --list of LSP servers for mason to install
            ensure_installed = {
                "clangd", --C/C++
                "jdtls", --Java
                "pyright", --Python
                "lua-language-server", --Lua
                "html-lsp", --HTML
                "css-lsp", --CSS, SCSS, LESS
                "typescript-language-server", --JavaScript, TypeScript, JSX, TSX,
                "vue-language-server", --Vue
                "json-lsp", --JSON
                "lemminx", --XML
                "yaml-language-server", --YAML
                "sqlls", --SQL
                "marksman", --Markdown
                "texlab", --LaTeX
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
        event = "VeryLazy",
        config = function()
            --enable servers
            local servers = {
                "clangd",
                "jdtls",
                "pyright",
                "lua_ls",
                "html",
                "cssls",
                "ts_ls",
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
