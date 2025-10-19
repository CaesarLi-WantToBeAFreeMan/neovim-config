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
                        "aerial"
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
                        "filename",
                        path = 0,--0 = filename only, 1 = relative path
                        color = {fg = "#cc7722", bg = "#151b54"}
                    },
                    {
                        function()
                            return string.format(
                                " %d", #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR})
                            )
                        end,
                        color = {fg = "#e06c75"},
                    },
                    {
                        function()
                            return string.format(
                                " %d", #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.WARN})
                            )
                        end,
                        color = {fg = "#e5c07b"},
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
                            return "🕗 " .. os.date("%H:%M:%S")
                        end,
                        color = {fg = "#ffffff", bg = "#282c34"}
                    }
                }
            }
        })
    end
}
