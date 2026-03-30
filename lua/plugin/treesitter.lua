return {
    --syntax parsing
    {
        "nvim-treesitter/nvim-treesitter", --syntax parsing for highlighting and more
        build = ":TSUpdate", --update parsers on install
        event = "VeryLazy",
        priority = 900,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects", --text objects
        },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    --programming languages
                    "c",
                    "cpp",
                    "python",
                    "java",
                    "lua",
                    "vim",
                    "rust",
                    "go",

                    --web development
                    "http",
                    "graphql",
                    "html",
                    "css",
                    "scss",
                    "javascript",
                    "typescript",
                    "tsx",
                    "vue",
                    "json",
                    "json5",
                    "jsonc",
                    "xml",
                    "yaml",
                    "toml",

                    --markup & documentation
                    "markdown",
                    "markdown_inline",
                    --"mermaid", experimental
                    "latex",
                    "vimdoc",
                    "javadoc",

                    --configuration files
                    "make",
                    "cmake",
                    "dockerfile",
                    "jsdoc",
                    "llvm",
                    "luadoc",

                    --database
                    "csv",
                    "tsv",
                    "sql",
                    "regex",
                    "nginx",

                    --shell
                    "bash",
                    "powershell",

                    --git
                    "git_config",
                    "git_rebase",
                    "gitcommit",
                    "gitignore",
                },
                auto_install = true, --install missing parsers automatically
                highlight = { --enable treesitter-based highlighting
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true }, --enable treeisitter-based indentation
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>", --start selection
                        node_incremental = "<CR>", --expand node selection
                        node_decremental = "<S-CR>", --shrink node selection
                        scope_incremental = "<BS>", --expand to scope
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, --jump to text object
                        keymaps = {
                            --functions
                            ["af"] = "@function.outer", --around function
                            ["if"] = "@function.inner", --inside function

                            --classes
                            ["ac"] = "@class.outer", --around class
                            ["ic"] = "@class.inner", --inside class

                            --conditionals
                            ["ai"] = "@conditional.outer", --around if
                            ["ii"] = "@conditional.inner", --inside if

                            --loops
                            ["al"] = "@loop.outer", --around loop
                            ["il"] = "@loop.inner", --inside loop

                            --parameters/arguments
                            ["ap"] = "@parameter.outer", --around parameter/argument
                            ["ip"] = "@parameter.inner", --inside parameter/argument

                            --comments
                            ["a/"] = "@comment.outer", --around comment
                            ["i/"] = "@comment.inner", --inside comment

                            --blocks
                            ["ab"] = "@block.outer", --around block
                            ["ib"] = "@block.inner", --inside block
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                        },
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]c"] = "@class.outer",
                        },
                    },
                },
            })
            --folding
            vim.opt.foldmethod = "expr" --use expression-based folding
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()" --use treesitter for folding
        end,
    },
    --show the current function/class/scope header at the top of the window
    {
        "nvim-treesitter/nvim-treesitter-context", --context viewer for code
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter", --load treesitter
        },
        opts = {
            enable = true, --enable context viewer
            max_lines = 5, --show up to 5 context lines
            min_window_height = 30, --minimum window height for context
            line_numbers = true, --show line numbers in context
            multiline_threshold = 1, --maximum lines for single context
            trim_scope = "outer", --trim scope to outer function
            mode = "cursor", --use cursor for context calculation
            separator = "󰇘", --separator between context and content
            zindex = 21, --context window z-index
        },
        keys = {
            {
                "[x",
                function() require("treesitter-context").go_to_context(vim.v.count1) end,
                mode = "n",
                silent = true,
                desc = "jump to context",
            },
            {
                "]x",
                "<C-i>",
                mode = "n",
                silent = true,
                desc = "jump back from context",
            },
        },
    },
}
