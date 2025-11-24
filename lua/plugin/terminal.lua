return {
    "rebelot/terminal.nvim",
    keys = {
        {
            "<C-,>",
            function() require("terminal").toggle() end,
            mode = "n",
            desc = "toggle terminal",
        },
    },
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
    end,
}
