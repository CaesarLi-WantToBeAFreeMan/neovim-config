return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
        require("tiny-inline-diagnostic").setup({
            preset = "modern",
            options = {
                show_source = false,
                show_code = false,
                use_icons_from_diagnostic = true,
                set_arrow_to_diag_color = true,
                enable_on_insert = false,
                enable_on_select = false,
                truncate_line = true,
                show_diags_only_under_cursor = true,
                add_messages = {
                    use_max_severity = true,
                    show_multiple_glyphs = false,
                },
                severity_sort = true, --highest severity shown first
                multiple_diag_under_cursor = false, --only display exact one diagnostic
                multilines = {
                    enabled = false, --don't display multiple diagnostics per line
                    always_show = false,
                },
                overflow = {
                    mode = "wrap", --wrap message if too long
                },

                --throttle diagnostic refresh (ms) to reduce flickering
                throttle = 20,
            },
        })
    end,
}
