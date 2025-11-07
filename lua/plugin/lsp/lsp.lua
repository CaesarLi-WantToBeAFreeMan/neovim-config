 return{
    --LSP server installer
    {
        "williamboman/mason.nvim",
        opts = {
            --list of LSP servers for mason to install
            ensure_installed = {
                "clangd",                                           --C/C++
                "jdtls",                                            --Java
                "pyright",                                          --Python
                "lua-language-server",                              --Lua
                "html-lsp",                                         --HTML
                "css-lsp",                                          --CSS, SCSS, LESS
                "typescript-language-server",                       --JavaScript, TypeScript, JSX, TSX,
                "vue-language-server",                              --Vue
                "json-lsp",                                         --JSON
                "lemminx",                                          --XML
                "yaml-language-server",                             --YAML
                "sqlls",                                            --SQL
                "marksman",                                         --Markdown
                "texlab"                                            --LaTeX
            },
            ui = {
                icons = {
                    package_installed = "",
                    package_pending = "󱑤",
                    package_uninstalled = ""
                }
            }
        }
    },

    --LSP configurations
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvim-telescope/telescope.nvim"
        },
        opts = {
            diagnostics = {virtual_text = false}    --handle via tiny-inline-diagnostic
        },
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
                "texlab"
            }

            for _, server in ipairs(servers) do
                vim.lsp.enable(server)
            end

            --keymaps
            local set = function(mode, key, action, description)
                vim.keymap.set(mode, key, action, {noremap = true, silent = true, desc = description})
            end

            set("i", "<C-h>", vim.lsp.buf.signature_help, "show signature help")
            set("n", "gd", vim.lsp.buf.definition, "go to definition")
            set("n", "gD", vim.lsp.buf.declaration, "go to declaration")
            set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "list implementations")
            set("n", "gR", "<cmd>Telescope lsp_references<CR>", "list references")
            set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "list type definitions")
            set({"n", "v"}, "<leader>la", vim.lsp.buf.code_action, "select code action")
            set("n", "gr", vim.lsp.buf.rename, "rename symbol")
            set("n", "gl", "<cmd>Telescope diagnostics bufnr=0<CR>", "list diagnostics in current buffer")
            set("n", "gh", vim.lsp.buf.hover, "show hover")

            --change line diagnostic icons
            local severity = vim.diagnostic.severity
            vim.diagnostic.config({
                signs = {
                    text = {
                        [severity.ERROR] = "",
                        [severity.WARN] = "",
                        [severity.HINT] = "",
                        [severity.INFO] = "",
                    }
                }
            })
        end
    }
}
