return{
    "stevearc/conform.nvim",
    dependencies = {
        "mason.nvim"
    },
    event = "VeryLazy",
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>lf",
            function() require("conform").format({ async = true, lsp_fallback = true }) end,
            mode = { "n", "x" },
            desc = "format code",
        },
    },
    config = function()
        local formatter_path = string.format(
            "%s/%s/nvim/lua/lsp",
            vim.fn.expand("~"),
            vim.fn.has("win32") == 1 and "AppData/Local" or ".config"
        )

        require("conform").setup({
            format_on_save = {
                timeout_ms = 3000,
                lsp_format = "fallback",
            },

            formatters_by_ft = {
                lua = { "stylua" },
                c = { "clang_format" },
                h = { "clang_format" },
                cpp = { "clang_format" },
                hpp = { "clang_format" },
                java = { "clang_format" },
                --puthon = {""},
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                sass = { "prettier" },
                less = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                jsx = { "prettier" },
                tsx = { "prettier" },
                json = { "prettier" },
                vue = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
            },

            --formatter configurations
            formatters = {
                stylua = {
                    command = "stylua",
                    prepend_args = { "--config-path", formatter_path .. "/stylua.toml" },
                },
                clang_format = {
                    command = "clang-format",
                    prepend_args = { "--style=file:" .. formatter_path .. "/.clang-format" },
                },
                prettier = {
                    command = "prettier",
                    prepend_args = { "--config", formatter_path .. "/prettier.json" },
                },
            },
        })
    end,
}
