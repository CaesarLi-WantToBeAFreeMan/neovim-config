--Caesar's prefer colorscheme
return{
    "navarasu/onedark.nvim",
    lazy = false,--load immediately
    priority = 1000,--load before other plugins
    config = function()
        --setup onedark colorscheme
        require("onedark").setup({
            style = "deep"--themes: dark, darker, cool, deep, warm, warmer
        })
        require("onedark").load()--load the colorscheme

        --custom highlight overrides
        local highlights = {
            LineNr = {fg = "#ffffff", bg = "NONE"},
            CursorLineNr = {fg = "#00ffff", bg = "NONE", bold = true},
            CursorLine = {bg = "#333333"},
            CursorColumn = {bg = "#333333"},
            Search = {fg = "#00ffff", bg = "#756a22"},
            MsgArea = {fg = "#00ffff"},
            MoreMsg = {fg = "#00ffff"},
            Question = {fg = "#00ffff"},
            ModeMsg = {fg = "#00ffff"},
            Cursor = {fg = "#ff0000"},
        }

        --apply all highlight overrides
        for group, settings in pairs(highlights) do
            vim.api.nvim_set_hl(0, group, settings)
        end
    end,
}
