--status line
return{
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    event = "VeryLazy",
    config = function()
        require("lualine").setup({
            options = {
                theme = "onedark",
                globalstatus = true,
                section_separators = {left = "", right = ""},
                component_separators = {left = "", right = ""},
                disabled_filetypes = {
                    statusline = {"neo-tree"},
                    winbar = {},
                },
            },
            sections = {
                lualine_a = {"mode"},
                lualine_b = {
                    {
                        "branch",
                        icon = "󰊢",
                        color = {fg = "#00ffff", bg = "#f1502f", gui = "bold"},
                    },
                },
                lualine_c = {
                    {
                        function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if not gitsigns then
                                return ""
                            end
                            if gitsigns.added and gitsigns.added > 0 then
                                return string.format(" %d", gitsigns.added)
                            end
                            return ""
                        end,
                        color = {fg = "#98c379"},
                    },
                    {
                        function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if not gitsigns then
                                return ""
                            end
                            if gitsigns.removed and gitsigns.removed > 0 then
                                return string.format(" %d", gitsigns.removed)
                            end
                            return ""
                        end,
                        color = {fg = "#e06c75"},
                    },
                    {
                        function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if not gitsigns then
                                return ""
                            end
                            if gitsigns.changed and gitsigns.changed > 0 then
                                return string.format(" %d", gitsigns.changed)
                            end
                            return ""
                        end,
                        color = {fg = "#e5c07b"},
                    },
                    {
                        "filename",
                        path = 0,--0 = filename only, 1 = relative path
                        color = {fg = "#cc7722", bg = "#151b54"},
                    },
                    {
                        function()
                            local count = #(vim.diagnostic.get(
                                0, {
                                    severity = vim.diagnostic.severity.ERROR
                                }
                            ))
                            if count > 0 then
                                return string.format(" %d", count)
                            end
                            return ""
                        end,
                        color = {fg = "#e06c75"},
                    },
                    {
                        function()
                            local count = #(vim.diagnostic.get(
                                0, {
                                    severity = vim.diagnostic.severity.WARN
                                }
                            ))
                            if count > 0 then
                                return string.format(" %d", count)
                            end
                            return ""
                        end,
                        color = {fg = "#e5c07b"},
                    },
                },
                lualine_x = {"encoding", "filetype", "fileformat"},
                lualine_y = {
                    {
                        function()
                            return string.format(
                                " %d/%d",
                                vim.fn.line("."),
                                vim.fn.line("$")
                            )
                        end,
                        color = {fg = "#ffbb00", bg = "#00a1f1"},
                    },
                    {
                        function()
                            return string.format(
                                " %d/%d",
                                vim.fn.col("."),
                                vim.fn.col("$") - 1
                            )
                        end,
                        color = {fg = "#f65314", bg = "#7cbb00"},
                    },
                },
                lualine_z = {
                    {
                        function()
                            return "🕗 " .. os.date("%H:%M:%S")
                        end,
                        color = {fg = "#ffffff", bg = "#282c34"},
                    },
                },
            },
        })
    end,
}
