return{
    --onedark colorscheme
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        config = function()
            require("onedark").setup({
                style = "deep", --themes: dark, darker, cool, deep, warm, warmer
            })
            require("onedark").load() --apply colorscheme
            local highlights = {
                LineNr = { fg = "#ffffff", bg = "NONE" }, --white line numbers
                CursorLineNr = { fg = "#00ffff", bg = "NONE", bold = true }, --cyan bold current line number
                CursorLine = { bg = "#333333" }, --dark gray cursor line
                CursorColumn = { bg = "#333333" }, --dark cray cursor column
                Search = { fg = "#00ffff", bg = "#756a22" }, --cyan search with alive background
                MsgArea = { fg = "#00ffff" }, --cyan message area
                MoreMsg = { fg = "#00ffff" }, --cyan more messages
                Question = { fg = "#00ffff" }, --cyan questions
                ModeMsg = { fg = "#00ffff" }, --cyan mode messages
                Cursor = { fg = "#ff0000" }, --red cursor
            }
            for group, settings in pairs(highlights) do
                vim.api.nvim_set_hl(0, group, settings) --apply highlight overrides
            end
        end,
    },
}
