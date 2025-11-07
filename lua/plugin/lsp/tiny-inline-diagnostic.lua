return{
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require("tiny-inline-diagnostic").setup({
            preset = "powerline"    --modern, classic, minimal, powerline, ghost, simple, nonerdfont, amongus themes
        })
    end
}
