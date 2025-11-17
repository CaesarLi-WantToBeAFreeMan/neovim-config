return {
    "nvimdev/dashboard-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local title = vim.o.columns >= 130
                and {
                    "",
                    "",
                    "",
                    "   ░██████      ░█████ ░██         ░██               ░███    ░██                                  ░██                ",
                    " ░██   ░██       ░██  ░██         ░██               ░████   ░██                                                      ",
                    "░██              ░██  ░██         ░██  ░███████     ░██░██  ░██  ░███████   ░███████  ░██    ░██ ░██░█████████████   ",
                    "░██              ░██  ░██             ░██           ░██ ░██ ░██ ░██    ░██ ░██    ░██ ░██    ░██ ░██░██   ░██   ░██  ",
                    "░██        ░██   ░██  ░██              ░███████     ░██  ░██░██ ░█████████ ░██    ░██  ░██  ░██  ░██░██   ░██   ░██  ",
                    " ░██   ░██ ░██   ░██  ░██                    ░██    ░██   ░████ ░██        ░██    ░██   ░██░██   ░██░██   ░██   ░██  ",
                    "  ░██████   ░██████   ░██████████      ░███████     ░██    ░███  ░███████   ░███████     ░███    ░██░██   ░██   ░██  ",
                    "",
                    "",
                    "",
                }
            or {
                "",
                "",
                "",
                "  ░██████  ░███    ░██            ░██                ",
                " ░██   ░██ ░████   ░██                               ",
                "░██        ░██░██  ░██ ░██    ░██ ░██░█████████████  ",
                "░██        ░██ ░██ ░██ ░██    ░██ ░██░██   ░██   ░██ ",
                "░██        ░██  ░██░██  ░██  ░██  ░██░██   ░██   ░██ ",
                " ░██   ░██ ░██   ░████   ░██░██   ░██░██   ░██   ░██ ",
                "  ░██████  ░██    ░███    ░███    ░██░██   ░██   ░██ ",
                "",
                "",
                "",
            }
        require("dashboard").setup({
            theme = "doom",
            config = {
                header = title,
                center = {
                    {
                        icon = "󰈔   ",
                        icon_hl = "button_icon",
                        desc = "New File",
                        desc_hl = "button_new_file",
                        key = "n",
                        action = "enew",
                    },
                    {
                        icon = "󰱼   ",
                        icon_hl = "button_icon",
                        desc = "Find File",
                        desc_hl = "button_find_file",
                        key = "f",
                        action = "Telescope find_files",
                    },
                    {
                        icon = "󱋡   ",
                        icon_hl = "button_icon",
                        desc = "Recently Opened Files",
                        desc_hl = "button_recently_opened_files",
                        key = "r",
                        action = "Telescope oldfiles",
                    },
                    {
                        icon = "󰪺   ",
                        icon_hl = "button_icon",
                        desc = "Open Recently Opened Session",
                        desc_hl = "button_open_rencently_opened_session",
                        key = "o",
                        action = "AutoSession restore",
                    },
                    {
                        icon = "󰥨   ",
                        icon_hl = "button_icon",
                        desc = "Find Session",
                        desc_hl = "button_find_session",
                        key = "F",
                        action = "AutoSession search",
                    },
                    {
                        icon = "󰒲   ",
                        icon_hl = "button_icon",
                        desc = "Lazy",
                        desc_hl = "button_lazy",
                        key = "l",
                        action = "Lazy",
                    },
                    {
                        icon = "󰅚   ",
                        icon_hl = "button_icon",
                        desc = "Quit",
                        desc_hl = "button_quit",
                        key = "q",
                        action = "qa",
                    },
                },
                footer = function()
                    local stats = require("lazy").stats()
                    local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
                    local count = stats.count
                    return {
                        "╔════════════════════════════════════════════════════════════════╗",
                        "║              Welcome to Caesar James LEE's Neovim              ║",
                        "║                                                                ║",
                        string.format(
                            "║                  %d plugins loaded in %07.2f ms               ║",
                            count,
                            ms
                        ),
                        "║                                                                ║",
                        "╚════════════════════════════════════════════════════════════════╝",
                    }
                end,
            },
        })

        --set highlight groups
        local highlight = function(name, hl) vim.api.nvim_set_hl(0, name, hl) end

        highlight("DashboardHeader", { fg = "#00ffff", bold = true })
        highlight("DashboardFooter", { fg = "#56b6c2", bold = true })
        highlight("button_icon", { fg = "#f1502f", italic = true })

        highlight("button_new_file", { fg = "#98c379" })
        highlight("button_find_file", { fg = "#61afef" })
        highlight("button_recently_opened_files", { fg = "#c678dd" })
        highlight("button_open_rencently_opened_session", { fg = "#e5c07b" })
        highlight("button_find_session", { fg = "#e06c75" })
        highlight("button_new_session", { fg = "#56b6c2" })
        highlight("button_lazy", { fg = "#f1502f" })
        highlight("button_quit", { fg = "#abb2bf" })

        --hide UI elements
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "dashboard",
            callback = function()
                vim.opt_local.showtabline = 0
                vim.opt_local.laststatus = 0
            end,
        })

        vim.api.nvim_create_autocmd("BufUnload", {
            pattern = "dashboard",
            callback = function() vim.opt.laststatus = 3 end,
        })
    end,
}
