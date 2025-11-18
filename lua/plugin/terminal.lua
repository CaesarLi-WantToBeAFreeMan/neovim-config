return {
    "rebelot/terminal.nvim",
    event = "VeryLazy",
    config = function()
        require("terminal").setup({
            default_cwd = vim.fn.getcwd(),
            layout = {
                open_cmd = "split", --open in horizontal split window
                size = 12, --height
            },
            float_opts = {
                border = "rounded",
            },
        })

        vim.keymap.set(
            "n",
            "<C-,>",
            function() require("terminal").toggle() end,
            { noremap = true, nowait = true, desc = "toggle terminal" }
        )
    end,
}
