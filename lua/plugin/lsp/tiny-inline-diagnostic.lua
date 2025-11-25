return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = {"BufReadPost", "BufNewFile"},
    priority = 1000,
    config = function()
        require("tiny-inline-diagnostic").setup({
            preset = "powerline",
            options = {
                show_source = true,
                set_arrow_to_diag_color = true,
                enable_on_select = true,
                truncate_line = true,
            },
        })
    end,
}
