return{
    --LSP server installer
    {
        "williamboman/mason.nvim",
        opts = {
            --list of LSP servers for mason to install
            ensure_installed = {"clangd", "cssls", "html", "jdtls", "lemminx", "lua_ls", "marksman", "pyright", "sqlls", "texlab", "ts_ls", "jsonls", "vue_ls", "yamlls"},
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
        config = function()
            --enable servers
            local servers = {"clangd", "cssls", "html", "jdtls", "lemminx", "lua_ls", "marksman", "pyright", "sqlls", "texlab", "ts_ls", "jsonls", "vue_ls", "yamlls"};

            for _, server in ipairs(servers) do
                vim.lsp.enable(server);
            end

            --keymaps
            local telescope_builtin = require("telescope.builtin")
            local themes = require("telescope.themes")
            local set = function(mode, key, action, description)
                vim.keymap.set(mode, key, action, {noremap = true, silent = true, desc = description})
            end

            set("i", "<C-h>", vim.lsp.buf.signature_help, "show LSP signature help")
            set("n", "gd", vim.lsp.buf.type_definition, "go to definition")
            set("n", "gi", vim.lsp.buf.implementation, "go to implementation")
            set("n", "<leader>la",
                function()
                    vim.lsp.buf.code_action(themes.get_dropdown({}))
                end,
                "select code action")
            set("n", "grs", vim.lsp.buf.rename, "rename LSP symbol")
            set("n", "<leader>fR",
                function()
                    telescope_builtin.lsp_references(themes.get_dropdown({}))
                end,
                "list LSP references")
        end
    }
}
