return {
    "nvim-lualine/lualine.nvim", --statusline plugin
    dependencies = {
        "nvim-tree/nvim-web-devicons", --file icons
        "lewis6991/gitsigns.nvim", --gitsigns
    },
    event = "VeryLazy", --load on VeryLazy event
    config = function()
        local is_wide = function() return vim.api.nvim_get_option_value("columns", {}) >= 130 end
        local git_sign_count = function(type)
            local icon = type == "add" and "" or type == "remove" and "" or type == "change" and "" or ""
            local gitsigns = vim.b.gitsigns_status_dict

            if not gitsigns then return "" end

            local count = type == "add" and gitsigns.added
                or type == "remove" and gitsigns.removed
                or type == "change" and gitsigns.changed
                or 0
            return count == 0 and "" or string.format("%s %d", icon, count)
        end
        local lsp_diagnostic_count = function(type)
            local icon = type == "error" and "" or type == "warning" and "" or type == "hint" and "󰌵" or ""
            local diagnostic = vim.diagnostic.severity
            local count = #vim.diagnostic.get(0, {
                severity = type == "error" and diagnostic.ERROR
                    or type == "warning" and diagnostic.WARN
                    or type == "hint" and diagnostic.HINT
                    or diagnostic.INFO,
            })
            return count == 0 and "" or string.format("%s %d", icon, count)
        end

        require("lualine").setup({
            options = {
                theme = "onedark", --use onedark theme
                globalstatus = true, --enable global statusline
                section_separators = { left = "", right = "" }, --section separators
                component_separators = { left = "", right = "" }, --component separators
                disabled_filetypes = {
                    statusline = { --disable statusline
                        "neo-tree",
                        "trouble",
                        "dashboard",
                    },
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    {
                        "branch",
                        icon = "󰊢",
                        color = { fg = "#00ffff", bg = "#f1502f", gui = "bold" },
                    },
                    {
                        "filename",
                        path = is_wide() and 1 or 0,
                        color = { fg = "#000000", bg = "#f16c9a" },
                    },
                },
                lualine_c = {
                    {
                        function() return git_sign_count("add") end,
                        color = { fg = "#98c379" },
                    },
                    {
                        function() return git_sign_count("remove") end,
                        color = { fg = "#e06c75" },
                    },
                    {
                        function() return git_sign_count("change") end,
                        color = { fg = "#e5c07b" },
                    },
                    {
                        function() return lsp_diagnostic_count("error") end,
                        color = { fg = "#e06c75" },
                    },
                    {
                        function() return lsp_diagnostic_count("warning") end,
                        color = { fg = "#e5c07b" },
                    },
                    {
                        function() return is_wide() and lsp_diagnostic_count("hint") or "" end,
                        color = { fg = "#645394" },
                    },
                    {
                        function() return is_wide() and lsp_diagnostic_count("info") or "" end,
                        color = { fg = "#028a0f" },
                    },
                },
                lualine_x = { "encoding", "filetype", "fileformat" },
                lualine_y = {
                    {
                        function() return string.format(" %d/%d", vim.fn.line("."), vim.fn.line("$")) end,
                        color = { fg = "#ffbb00", bg = "#00a1f1" },
                    },
                    {
                        function() return string.format(" %d/%d", vim.fn.col("."), vim.fn.col("$") - 1) end,
                        color = { fg = "#f65314", bg = "#7cbb00" },
                    },
                },
                lualine_z = {
                    {
                        function()
                            local t = os.date("*t")
                            if is_wide() then
                                local WEEK, am_or_pm =
                                    { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" }, t.hour < 12 and "am" or "pm"
                                return string.format(
                                    "🕗 %s %02d/%02d, %02d %02d:%02d:%02d %s",
                                    WEEK[t.wday],
                                    t.month,
                                    t.day,
                                    t.year % 100,
                                    t.hour % 12 == 0 and 12 or t.hour % 12,
                                    t.min,
                                    t.sec,
                                    am_or_pm
                                )
                            else
                                return string.format("🕗 %02d:%02d:%02d", t.hour, t.min, t.sec)
                            end
                        end,
                        color = { fg = "#ffffff", bg = "#282c34" },
                    },
                },
            },
        })
    end,
}
