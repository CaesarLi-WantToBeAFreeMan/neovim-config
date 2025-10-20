return {
    "nvimdev/dashboard-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("dashboard").setup({
            theme = "doom",
            config = {
                header = {
                    "",
                    "",
                    "",
                    "   █████████        █████ █████        ██            ██████   █████                    ███                 ",
                    "  ███▒▒▒▒▒███      ▒▒███ ▒▒███        ███           ▒▒██████ ▒▒███                    ▒▒▒                  ",
                    " ███     ▒▒▒        ▒███  ▒███       ▒▒▒   █████     ▒███▒███ ▒███   ██████   ██████  ████  █████████████  ",
                    "▒███                ▒███  ▒███            ███▒▒      ▒███▒▒███▒███  ███▒▒███ ███▒▒███▒▒███ ▒▒███▒▒███▒▒███ ",
                    "▒███                ▒███  ▒███           ▒▒█████     ▒███ ▒▒██████ ▒███████ ▒███ ▒███ ▒███  ▒███ ▒███ ▒███ ",
                    "▒▒███     ███ ███   ▒███  ▒███      █     ▒▒▒▒███    ▒███  ▒▒█████ ▒███▒▒▒  ▒███ ▒███ ▒███  ▒███ ▒███ ▒███ ",
                    " ▒▒█████████ ▒▒████████   ███████████     ██████     █████  ▒▒█████▒▒██████ ▒▒██████  █████ █████▒███ █████",
                    "  ▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒     ▒▒▒▒▒▒     ▒▒▒▒▒    ▒▒▒▒▒  ▒▒▒▒▒▒   ▒▒▒▒▒▒  ▒▒▒▒▒ ▒▒▒▒▒ ▒▒▒ ▒▒▒▒▒ ",
                    "",
                    "",
                    ""
                },
                center = {
                    {
                        icon = "󰈔   ",
                        icon_hl = "button_icon",
                        desc = "New File",
                        desc_hl = "button_new_file",
                        key = "n",
                        action = "enew"
                    },
                    {
                        icon = "󰱼   ",
                        icon_hl = "button_icon",
                        desc = "Find File",
                        desc_hl = "button_find_file",
                        key = "f",
                        action = "Telescope find_files"
                    },
                    {
                        icon = "󱋡   ",
                        icon_hl = "button_icon",
                        desc = "Recently Opened Files",
                        desc_hl = "button_recently_opened_files",
                        key = "r",
                        action = "Telescope oldfiles"
                    },
                    {
                        icon = "󰒲   ",
                        icon_hl = "button_icon",
                        desc = "Lazy",
                        desc_hl = "button_lazy",
                        key = "l",
                        action = "Lazy"
                    },
                    {
                        icon = "󰅚   ",
                        icon_hl = "button_icon",
                        desc = "Quit",
                        desc_hl = "button_quit",
                        key = "q",
                        action = "qa"
                    }
                },
                footer = function()
                    local stats = require("lazy").stats()
                    local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
                    local count = stats.count
                    return {
                        "╔════════════════════════════════════════════════════════════════╗",
                        "║              Welcome to Caesar James LEE's Neovim              ║",
                        string.format("║                  %d plugins loaded in %07.2f ms               ║", count, ms),
                        "║                                                                ║",
                        "╚════════════════════════════════════════════════════════════════╝"
                    }
                end
            }
        })

        --set highlight groups
        local set_hl = vim.api.nvim_set_hl
        set_hl(0, "DashboardHeader",                {fg = "#00ffff",    bold = true})
        set_hl(0, "DashboardFooter",                {fg = "#56b6c2",    bold = true})
        set_hl(0, "button_icon",                    {fg = "#f1502f",    italic = true})

        set_hl(0, "button_new_file",                {fg = "#98c379"})
        set_hl(0, "button_find_file",               {fg = "#61afef"})
        set_hl(0, "button_recently_opened_files",   {fg = "#c678dd"})
        set_hl(0, "button_open_last_session",       {fg = "#e5c07b"})
        set_hl(0, "button_new_session",             {fg = "#56b6c2"})
        set_hl(0, "button_sessions",                {fg = "#e06c75"})
        set_hl(0, "button_lazy",                    {fg = "#56b6c2"})
        set_hl(0, "button_quit",                    {fg = "#abb2bf"})

        --hide UI elements
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "dashboard",
            callback = function()
                vim.opt_local.showtabline = 0
                vim.opt_local.laststatus = 0
            end
        })

        vim.api.nvim_create_autocmd("BufUnload", {
            pattern = "dashboard",
            callback = function()
                vim.opt.laststatus = 3
            end
        })
    end
}
