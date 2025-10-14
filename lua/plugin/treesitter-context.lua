--a current code context (class, function, loop, etc) viewer
--at the top of editor, like Microsoft Visual Studio Code
return {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
        "nvim-treesitter/nvim-treesitter"
    },
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        require("treesitter-context").setup({
            enable = true,
            max_lines = 5,-- Maximum lines to show
            min_window_height = 30,-- Minimum editor window height
            line_numbers = true,-- Show line numbers in context
            multiline_threshold = 1,-- Maximum lines for single context
            trim_scope = "outer",-- Trim scope at outer function
            mode = "cursor",-- Line used to calculate context
            separator = "󰇘",-- Separator between context and content
            zindex = 21,-- Z-index of context window
        })

        --keymap to jump to context
        vim.keymap.set("n", "[x", function()
            require("treesitter-context").go_to_context()
        end, {
            silent = true,
            desc = "jump to context"
        })
    end,
}
