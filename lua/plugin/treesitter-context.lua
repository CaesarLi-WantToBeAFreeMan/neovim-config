return {
    "nvim-treesitter/nvim-treesitter-context",              --context viewer for code
    event = {"BufReadPost", "BufNewFile"},                  --load on file open
    dependencies = {
        "nvim-treesitter/nvim-treesitter"                   --load treesitter
    },
    config = function()
        require("treesitter-context").setup({
            enable = true,                                  --enable context viewer
            max_lines = 5,                                  --show up to 5 context lines
            min_window_height = 30,                         --minimum window height for context
            line_numbers = true,                            --show line numbers in context
            multiline_threshold = 1,                        --maximum lines for single context
            trim_scope = "outer",                           --trim scope to outer function
            mode = "cursor",                                --use cursor for context calculation
            separator = "󰇘",                                --separator between context and content
            zindex = 21,                                    --context window z-index
        })
        vim.keymap.set("n", "[x", function ()
            require("treesitter-context").go_to_context(vim.v.count1)
        end,
        {silent = true, desc = "jump to context"})
    end
}
