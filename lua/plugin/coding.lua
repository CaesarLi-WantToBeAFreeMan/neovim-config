return {
    --auto pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true,
            ts_config = {
                lua = { "string" },
                javascript = { "string", "template_string" },
                typescript = { "string", "template_string" },
                java = false,
            },
            fast_wrap = { map = "<A-w>" }, --wrap next word in a pair
        },
    },
    --auto-close/rename HTML & XML tags
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "html",
            "xml",
            "vue",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        opts = {},
    },
    --surround manipulations
    {
        "echasnovski/mini.surround",
        event = "VeryLazy",
        opts = {
            mappings = {
                add = "sa", --add surrounding
                delete = "sd", --delete surrounding
                find = "sf", --find right surrounding
                find_left = "sF", --find left surrounding
                highlight = "sh", --highlight surrounding
                replace = "sc", --change surrounding
                update_n_lines = "sn", --update n lines
            },
        },
    },
    --extend a & i text objects
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    --blocks/conditions/loops
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
                    --function names with dot
                    n = ai.gen_spec.function_call(),
                    --function names without dot
                    N = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
                },
            }
        end,
    },
    --comment toggle
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            options = {
                custom_commentstring = function()
                    --use treesitter context for embedded languages
                    local ok, ts_context = pcall(require, "ts_context_commentstring.internal")
                    return ok and ts_context.calculate_commentstring() or nil
                end,
            },
        },
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring", --correct comments in mixed files
        },
    },
    --lua LSP
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
                { path = "lazy.nvim", words = { "LazyVim" } },
            },
        },
    },
    --preview colors
    {
        "Nvchad/nvim-colorizer.lua",
        event = "BufReadPost",
        opts = {
            filetypes = { "*" },
            user_default_options = {
                RGB = true,
                RRGGBB = true,
                names = true,
                RRGGBBAA = true,
                AARRGGBB = true,
                css = true,
                css_fn = true,
                tailwind = true,
                mode = "background",
            },
        },
    },
    --TODO comment highlights
    {
        "folke/todo-comments.nvim",
        event = "BufReadPost",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = true,
            keywords = {
                FIX = { icon = "", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
                TODO = { icon = "", color = "info" },
                HACK = { icon = "", color = "warning" },
                WARN = { icon = "", color = "warning", alt = { "WARNING" } },
                PERF = { icon = "󰓅", color = "default", alt = { "OPTIM", "PERFORMANCE" } },
                NOTE = { icon = "󰙎", color = "hint", alt = { "INFO" } },
                TEST = { icon = "󰙨", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
        },
        keys = {
            { "]o", function() require("todo-comments").jump_next() end, desc = "next todo" },
            { "[o", function() require("todo-comments").jump_prev() end, desc = "prev todo" },
            { "<leader>fo", "<cmd>TodoTelescope<cr>", desc = "find todos" },
        },
    },
    --pretty diagnostics/code action UI
    {
        "rachartier/tiny-code-action.nvim",
        event = "LspAttach",
        dependencies = { "nvim-telescope/telescope.nvim" },
        opts = {
            telescope_opts = {
                layout_strategy = "vertical",
                layout_config = {
                    width = 0.7,
                    height = 0.9,
                    preview_cutoff = 1,
                    preview_height = function(_, _, max_lines) return math.floor(max_lines * 0.5) end,
                },
            },
        },
        keys = {
            {
                "<leader>la",
                function() require("tiny-code-action").code_action() end,
                mode = { "n", "v" },
                desc = "pretty code actions",
            },
        },
    },
    --better increment/decrement
    {
        "monaqa/dial.nvim",
        event = "BufReadPost",
        keys = {
            { "<C-a>", function() require("dial.map").manipulate("increment", "normal") end, desc = "increment" },
            { "<C-x>", function() require("dial.map").manipulate("decrement", "normal") end, desc = "decrement" },
            {
                "g<C-a>",
                function() require("dial.map").manipulate("increment", "gnormal") end,
                desc = "sequential increment",
            },
            {
                "g<C-x>",
                function() require("dial.map").manipulate("decrement", "gnormal") end,
                desc = "sequential decrement",
            },
            {
                "<C-a>",
                function() require("dial.map").manipulate("increment", "visual") end,
                mode = "v",
                desc = "increment (visual)",
            },
            {
                "<C-x>",
                function() require("dial.map").manipulate("decrement", "visual") end,
                mode = "v",
                desc = "decrement (visual)",
            },
        },
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    --defaults
                    augend.integer.alias.decimal_int, ---1, 0, 1
                    augend.integer.alias.binary, --0b1
                    augend.integer.alias.octal, --0o1
                    augend.integer.alias.hex, --0x1
                    augend.date.alias["%Y/%m/%d"], --2026/12/25
                    augend.date.alias["%m/%d/%Y"], --12/25/2026
                    augend.date.alias["%m/%d/%y"], --12/25/26
                    augend.date.alias["%m/%d"], --12/25
                    augend.date.alias["%-m/%-d"], --9/11
                    augend.date.alias["%Y-%m-%d"], --2026-12-25
                    augend.date.alias["%Y年%-m月%-d日"], --2026年12月25日
                    augend.date.alias["%H:%M:%S"], --13:14:15
                    augend.date.alias["%H:%M"], --13:14
                    augend.constant.alias.en_weekday, --[Mon, Sun]
                    augend.constant.alias.en_weekday_full, --[Monday, Sunday]
                    augend.constant.alias.bool, --true/false
                    augend.constant.alias.Bool, --True/False
                    augend.constant.alias.alpha, --[a, z]
                    augend.constant.alias.Alpha, --[A, Z]
                    augend.semver.alias.semver, --0.0.1
                    --custom
                    --C++
                    augend.constant.new({ elements = { "short", "long" } }),
                    augend.constant.new({ elements = { "char", "string" } }),
                    augend.constant.new({ elements = { "float", "double" } }),
                    augend.constant.new({ elements = { "&&", "||" } }),
                    augend.constant.new({ elements = { "==", "!=" } }),
                    augend.constant.new({ elements = { ".", "->" } }),
                    augend.constant.new({ elements = { "public", "private", "protected" } }),
                    augend.constant.new({ elements = { "if", "else if", "else" } }),
                    augend.constant.new({ elements = { "for", "while", "do" } }),
                    --Java
                    augend.constant.new({ elements = { "class", "interface", "record", "enum" } }),
                    augend.constant.new({ elements = { "extends", "implements" } }),
                    augend.constant.new({
                        elements = { "Boolean", "Integer", "Long", "Double", "Float", "Character" },
                    }),
                    --JavaScript/TypeScript
                    augend.constant.new({ elements = { "let", "const", "var" } }),
                    augend.constant.new({ elements = { "===", "!==" } }),
                    --other
                    augend.constant.new({ elements = { "yes", "no" } }),
                    augend.constant.new({ elements = { "on", "off" } }),
                    augend.constant.new({ elements = { "and", "or" } }),
                },
            })
        end,
    },
    --better yank/paste
    {
        "gbprod/yanky.nvim",
        event = "BufReadPost",
        opts = {
            ring = { history_length = 20 },
            highlight = { on_put = true, on_yank = true, timer = 200 },
        },
        keys = {
            { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "yank" },
            { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "put after" },
            { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "put before" },
            { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "group put after" },
            { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "group put before" },
            { "<A-p>", "<Plug>(YankyCycleForward)", desc = "cycle yank forward" },
            { "<A-n>", "<Plug>(YankyCycleBackward)", desc = "cycle yank backward" },
        },
    },
}
