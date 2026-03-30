return {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    event = "VeryLazy",
    keys = {
        {
            "<leader>lf",
            function() require("conform").format({ async = true, lsp_fallback = true }) end,
            mode = { "n", "v" },
            desc = "format code",
        },
        {
            "<leader>tf",
            function()
                local conform = require("conform")
                if conform.format_on_save then
                    conform.format_on_save = nil
                    vim.notify("format on save disabled", vim.log.levels.INFO)
                else
                    conform.format_on_save = { timeout_ms = 3000, lsp_format = "fallback" }
                    vim.notify("format on save enabled", vim.log.levels.INFO)
                end
            end,
            mode = "n",
            desc = "toggle format on save",
        },
    },
    config = function()
        local sep = vim.fn.has("win32") == 1 and "\\" or "/"
        local formatter_path = table.concat({ vim.fn.stdpath("config"), "lua", "lsp" }, sep)

        require("conform").setup({
            format_on_save = {
                timeout_ms = 3000,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                --programming languages
                c = { "clang_format" },
                h = { "clang_format" },
                cpp = { "clang_format" },
                hpp = { "clang_format" },
                java = { "clang_format" },
                python = { "isort", "black" },
                lua = { "stylua" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                zsh = { "shfmt" },

                --web development
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                sass = { "prettier" },
                less = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                vue = { "prettier" },
                graphql = { "prettier" },

                --configuration
                xml = { "prettier" },
                yaml = { "prettier" },
                toml = { "taplo" },
                json = { "prettier" },
                jsonc = { "prettier" },

                --data
                sql = { "sql-formatter" },

                --documentation
                markdown = { "prettier" },
                tex = { "latexindent" },
            },
            formatters = {
                stylua = {
                    command = "stylua",
                    prepend_args = { "--config-path", formatter_path .. sep .. "stylua.toml" },
                },
                clang_format = {
                    command = "clang-format",
                    prepend_args = { "--style=file:" .. formatter_path .. sep .. "clang-format" },
                },
                prettier = {
                    command = "prettier",
                    prepend_args = { "--config", formatter_path .. sep .. "prettier.json" },
                },
                black = {
                    command = "black",
                    prepend_args = { "--line-length", "120" },
                },
                isort = {
                    command = "isort",
                    prepend_args = { "--profile", "black" },
                },
                shfmt = {
                    command = "shfmt",
                    prepend_args = { "-i", "4" },
                },
                ["sql-formatter"] = { command = "sql-formatter" },
                yamlfmt = { command = "yamlfmt" },
                taplo = {
                    command = "taplo",
                    args = { "fmt", "-" },
                },
                latexindent = {
                    command = "latexindent",
                    args = { "-" },
                },
            },
        })
    end,
}
