return {
    {
        "nvim-treesitter/nvim-treesitter", --syntax parsing for highlighting and more
        build = ":TSUpdate", --update parsers on install
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects", --text objects
            "nvim-treesitter/nvim-treesitter-context", --show context(function name at top)
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    --programming languages
                    "c",
                    "cpp",
                    "python",
                    "java",
                    "lua",
                    "vim",

                    --web development
                    "http",
                    "html",
                    "css",
                    "scss",
                    "javascript",
                    "typescript",
                    "vue",
                    "json",
                    "json5",
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

                    --command
                    "bash",
                    "powershell",

                    --git
                    "git_config",
                    "git_rebase",
                    "gitcommit",
                    "gitignore",
                },
                auto_install = true, --install missing parsers automatically
                highlight = { enable = true }, --enable treesitter-based highlighting
                indent = {
                    enable = true, --enable treeisitter-based indentation
                    disable = { "python", "yaml", "markdown" }, --use vim's default indentation
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>", --start selection
                        node_incremental = "<CR>", --expand node selection
                        node_decremental = "<S-CR>", --shrink node selection
                        scope_incremental = "<S-Tab>", --expand to scope
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
                        selection_modes = {
                            ["@parameter.outer"] = "v", --charwise
                            ["@function.outer"] = "V", --linewise
                            ["@class.outer"] = "V", --linewise
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>sf"] = "@function.inner", --swap with next function
                            ["<leader>sc"] = "@class.inner", --swap with next class
                            ["<leader>si"] = "@conditional.inner", --swap with next if
                            ["<leader>sl"] = "@loop.inner", --swap with next loop
                            ["<leader>sp"] = "@parameter.inner", --swap with next parameter
                            ["<leader>s/"] = "@comment.inner", --swap with next comment
                            ["<leader>sb"] = "@block.inner", --swap with next block
                        },
                        swap_previous = {
                            ["<leader>sF"] = "@function.inner", --swap with previous function
                            ["<leader>sC"] = "@class.inner", --swap with previous class
                            ["<leader>sI"] = "@conditional.inner", --swap with previous if
                            ["<leader>sL"] = "@loop.inner", --swap with previous loop
                            ["<leader>sP"] = "@parameter.inner", --swap with previous parameter
                            ["<leader>s?"] = "@comment.inner", --swap with previous comment
                            ["<leader>sB"] = "@block.inner", --swap with previous block
                        },
                    },
                    lsp_interop = {
                        enable = true,
                        border = "rounded", --use rounded borders for previews
                        peek_definition_code = {
                            ["<leader>pf"] = "@function.outer", --preview function
                            ["<leader>pc"] = "@class.outer", --preview class
                            ["<leader>pb"] = "@block.outer", --preview block
                        },
                    },
                },
            })
            vim.opt.foldmethod = "expr" --use expression-based folding
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()" --use treesitter for folding
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context", --context viewer for code
        dependencies = {
            "nvim-treesitter/nvim-treesitter", --load treesitter
        },
        config = function()
            require("treesitter-context").setup({
                enable = true, --enable context viewer
                max_lines = 5, --show up to 5 context lines
                min_window_height = 30, --minimum window height for context
                line_numbers = true, --show line numbers in context
                multiline_threshold = 1, --maximum lines for single context
                trim_scope = "outer", --trim scope to outer function
                mode = "cursor", --use cursor for context calculation
                separator = "󰇘", --separator between context and content
                zindex = 21, --context window z-index
            })
            vim.keymap.set(
                "n",
                "[x",
                function() require("treesitter-context").go_to_context(vim.v.count1) end,
                { silent = true, desc = "jump to context" }
            )
        end,
    },
}
