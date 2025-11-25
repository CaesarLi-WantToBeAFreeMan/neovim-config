return {
    --automatically insert a matching closing character
    {
        "nvim-mini/mini.pairs",
        event = { "InsertEnter" },
        opts = {
            modes = {
                insert = true,
                command = true,
                terminal = false,
            },
            --skip autopair when next character is one of below
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            --skip autopair inside a string
            skip_ts = { "string" },
            --skip autopair when next is closing pair and more closing pairs than opening pairs
            skip_unbalanced = true,
            --deal with markdown code blocks
            markdown = true,
        },
        config = function() require("mini.pairs").setup() end,
    },
    --auto-close/rename HTML/XML tags
    {
        "windwp/nvim-ts-autotag",
        ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        opts = {},
    },
    --surround manipulations
    {
        "echasnovski/mini.surround",
        config = function() require("mini.surround").setup() end,
    },
    --extend a & i text objects
    {
        "nvim-mini/mini.ai",
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    --blocks (block, conditions, loops)
                    b = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }),
                    --functions
                    f = ai.gen_spec.treesitter({
                        a = "@function.outer",
                        i = "@function.inner",
                    }),
                    --classes
                    c = ai.gen_spec.treesitter({
                        a = "@class.outer",
                        i = "@class.inner",
                    }),
                    --tags
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
                    --digits
                    d = { "%f[%d]%d+" },
                    --function name
                    n = ai.gen_spec.function_call(),
                    --function name without dot
                    N = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
                },
            }
        end,
        config = function(_, opts) require("mini.ai").setup(opts) end,
    },
    --configure LuaLs
    {
        "folke/lazydev.nvim",
        event = "VeryLazy",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%,uv" } },
                { path = "LazyVim",            words = { "LazyVim" } },
                { path = "lazy.nvim",          words = { "LazyVim" } },
            },
        },
    },
    --preview colors
    {
        "Nvchad/nvim-colorizer.lua",
        event = "BufReadPost",
        config = function()
            require("colorizer").setup({
                filetypes = { "*" },
                user_default_options = {
                    RGB = true,
                    RRGGBB = true,
                    names = true,
                    RRGGBBAA = true,
                    AARRGGBB = true,
                    css = true,
                    css_fn = true,
                    mode = "background", --background, foreground
                },
            })
        end,
    },
}
