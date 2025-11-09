return{
    "nvim-lualine/lualine.nvim",            --statusline plugin
    dependencies = {
        "nvim-tree/nvim-web-devicons",      --file icons
        "lewis6991/gitsigns.nvim"           --gitsigns
    },
    event = "VeryLazy",                     --load on VeryLazy event
    config = function()
        require("lualine").setup({
            options = {
                theme = "onedark",          --use onedark theme
                globalstatus = true,        --enable global statusline
                section_separators = {left = "", right = ""},     --section separators
                component_separators = {left = "", right = ""},   --component separators
                disabled_filetypes = {
                    statusline = {                                  --disable statusline
                        "neo-tree",
                        "trouble"
                    }
                }
            },
            sections = {
                lualine_a = {"mode"},
                lualine_b = {
                    {
                        "branch",
                        icon = "󰊢",
                        color = {fg = "#00ffff", bg = "#f1502f", gui = "bold"}
                    },
                    {
                        "filename",
                        path = 1,--0 = filename only, 1 = relative path
                        color = {fg = "#000000", bg = "#f16c9a"}
                    }
                },
                lualine_c = {
                    {
                        function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            return gitsigns and string.format(" %d", gitsigns.added) or ""
                        end,
                        color = {fg = "#98c379"}
                    },
                    {
                        function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            return gitsigns and string.format(" %d", gitsigns.removed) or ""
                        end,
                        color = {fg = "#e06c75"}
                    },
                    {
                        function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            return gitsigns and string.format(" %d", gitsigns.changed) or ""
                        end,
                        color = {fg = "#e5c07b"}
                    },
                    {
                        function()
                            return string.format(
                                "󰅙 %d", #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR})
                            )
                        end,
                        color = {fg = "#e06c75"}
                    },
                    {
                        function()
                            return string.format(
                                " %d", #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.WARN})
                            )
                        end,
                        color = {fg = "#e5c07b"}
                    },
                    {
                        function()
                            return string.format(
                                " %d", #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.HINT})
                            )
                        end,
                        color = {fg = "#645394"}
                    },
                    {
                        function()
                            return string.format(
                                " %d", #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.INFO})
                            )
                        end,
                        color = {fg = "#028a0f"}
                    }
                },
                lualine_x = {"encoding", "filetype", "fileformat"},
                lualine_y = {
                    {
                        function()
                            return string.format(" %d/%d", vim.fn.line("."), vim.fn.line("$"))
                        end,
                        color = {fg = "#ffbb00", bg = "#00a1f1"}
                    },
                    {
                        function()
                            return string.format(" %d/%d", vim.fn.col("."), vim.fn.col("$") - 1)
                        end,
                        color = {fg = "#f65314", bg = "#7cbb00"}
                    }
                },
                lualine_z = {
                    {
                        function()
                            local t = os.date("*t")
                            local WEEK, am_or_pm = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"}, t.hour < 12 and "A.M." or "P.M."
                            return string.format(
                                "🕗 %s %02d %02d, %02d %02d:%02d:%02d %s",
                                WEEK [t.wday],
                                t.month,
                                t.day,
                                t.year % 100,
                                t.hour % 12 == 0 and 12 or t.hour % 12,
                                t.min,
                                t.sec,
                                am_or_pm
                            )
                        end,
                        color = {fg = "#ffffff", bg = "#282c34"}
                    }
                }
            }
        })
    end
}
