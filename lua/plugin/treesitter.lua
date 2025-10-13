--a better highlighting, text objects, folding, selection, indentation tool based on
--abstract syntax tree (AST)
return{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",--auto-update parsers
    --a parser is an algorithm to show syntactic relation
    --of a part of a string to each other
    event = {"BufReadPost", "BufNewFile"},--load on opening files
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",--smart text objects
        "nvim-treesitter/nvim-treesitter-context",--show context(function name at top)
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            --[[
                +-=========-+
                | PARSERS   |
                +-=========-+
            ]]

            --install parsers
            ensure_installed = {
                --programming languages
                "c",
                "cpp",
                "python",
                "java",
                "lua",
                "vim",
                "vimdoc",
                "bash",

                --web development
                "html",
                "css",
                "scss",
                "javascript",
                "typescript",
                "tsx",
                "json",
                "xml",
                "yaml",
                "toml",

                --markup & documentation
                "markdown",
                "markdown_inline",

                --configuration files
                "make",
                "gitignore",
                "dockerfile",

                --database
                "sql",
                "regex"
            },
            sync_install = false,--only install parsers for ensure_installed
            auto_install = true,--automatically install missing parsers
            ignore_install = {},--list of parsers to ignore installing

            --[[
                +-=============-+
                | HIGHLIGHTNG   |
                +-=============-+
            ]]

            highlight = {
                enable = true,--enable treesitter-based highlighting
                disable = {},--disable for specific languages
                --disable addition vim regex highlighting
                additional_vim_regex_highlighting = false,
            },

            --[[
                +-=============-+
                | INDENTATION   |
                +-=============-+
            ]]

            indent = {
                enable = true,--enable treeisitter-based indentation
                disable = {--use vim's default indentation
                    "python",
                    "yaml",
                    "markdown",
                },
            },

            --[[
                +-=====================-+
                | INCREMENTAL SELECTION |
                +-=====================-+
            ]]

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",--start selection in normal mode
                    node_incremental = "<CR>",--expand selection
                    node_decremental = "<S-CR>",--shrink selection
                    scope_incremental = "<S-Tab>",--expand to scope
                },
            },

            --[[
                +-=============-+
                | TEXT OBJECTS  |
                +-=============-+
            ]]

            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,--automatically jump forward to text object
                    keymaps = {
                        --functions
                        ["af"] = "@function.outer",--around function
                        ["if"] = "@function.inner",--inside function

                        --classes
                        ["ac"] = "@class.outer",--around class
                        ["ic"] = "@class.inner",--inside class

                        --conditionals, i for if
                        ["ai"] = "@conditional.outer",--around if
                        ["ii"] = "@conditional.inner",--inside if

                        --loops
                        ["al"] = "@loop.outer",--around loop
                        ["il"] = "@loop.inner",--inside loop

                        --parameters/arguments
                        ["ap"] = "@parameter.outer",--around parameter/argument
                        ["ip"] = "@parameter.inner",--inside parameter/argument

                        --comments
                        ["a/"] = "@comment.outer",--around comment
                        ["i/"] = "@comment.inner",--inside comment

                        --blocks
                        ["ab"] = "@block.outer",--around block
                        ["ib"] = "@block.inner",--inside block
                    },

                    --include surrounding whitespace
                    selection_modes = {
                        ["@parameter.outer"] = "v",--charwise
                        ["@function.outer"] = "V",--linewise
                        ["@class.outer"] = "V",--linewise
                    },
                },

                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>sf"] = "@function.inner",--swap with next function
                        ["<leader>sc"] = "@class.inner",--swap with next class
                        ["<leader>si"] = "@conditional.inner",--swap with next if
                        ["<leader>sl"] = "@loop.inner",--swap with next loop
                        ["<leader>sp"] = "@parameter.inner",--swap with next parameter
                        ["<leader>s/"] = "@comment.inner",--swap with next comment
                        ["<leader>sb"] = "@block.inner",--swap with next block
                    },
                    swap_previous = {
                        ["<leader>sF"] = "@function.inner",--swap with previous function
                        ["<leader>sC"] = "@class.inner",--swap with previous class
                        ["<leader>sI"] = "@conditional.inner",--swap with previous if
                        ["<leader>sL"] = "@loop.inner",--swap with previous loop
                        ["<leader>sP"] = "@parameter.inner",--swap with previous parameter
                        ["<leader>s?"] = "@comment.inner",--swap with previous comment
                        ["<leader>sB"] = "@block.inner",--swap with previous block
                    },
                },

                --peek definition (show in floating window)
                lsp_interop = {
                    enable = true,
                    border = "rounded",
                    peek_definition_code = {
                        ["<leader>pf"] = "@function.outer",--preview function
                        ["<leader>pc"] = "@class.outer",--preview class
                        ["<leader>pb"] = "@block.outer",--preview block
                    },
                },
            },
        })

        --folding
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
}
