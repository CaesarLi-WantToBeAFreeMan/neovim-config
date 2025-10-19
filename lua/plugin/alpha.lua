return {
    "goolord/alpha-nvim",                                           --startup dashboard
    event = "VimEnter",                                             --load on Vim startup
    dependencies = {
        "nvim-tree/nvim-web-devicons"                               --file icons
    },
    config = function()
        local dashboard = require("alpha.themes.dashboard")         --load dashboard theme
        dashboard.section.header.val = {                            --set custom ASCII banner
            "",
            "   █████████        █████ █████        ██            ██████   █████                    ███                 ",
            "  ███▒▒▒▒▒███      ▒▒███ ▒▒███        ███           ▒▒██████ ▒▒███                    ▒▒▒                  ",
            " ███     ▒▒▒        ▒███  ▒███       ▒▒▒   █████     ▒███▒███ ▒███   ██████   ██████  ████  █████████████  ",
            "▒███                ▒███  ▒███            ███▒▒      ▒███▒▒███▒███  ███▒▒███ ███▒▒███▒▒███ ▒▒███▒▒███▒▒███ ",
            "▒███                ▒███  ▒███           ▒▒█████     ▒███ ▒▒██████ ▒███████ ▒███ ▒███ ▒███  ▒███ ▒███ ▒███ ",
            "▒▒███     ███ ███   ▒███  ▒███      █     ▒▒▒▒███    ▒███  ▒▒█████ ▒███▒▒▒  ▒███ ▒███ ▒███  ▒███ ▒███ ▒███ ",
            " ▒▒█████████ ▒▒████████   ███████████     ██████     █████  ▒▒█████▒▒██████ ▒▒██████  █████ █████▒███ █████",
            "  ▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒     ▒▒▒▒▒▒     ▒▒▒▒▒    ▒▒▒▒▒  ▒▒▒▒▒▒   ▒▒▒▒▒▒  ▒▒▒▒▒ ▒▒▒▒▒ ▒▒▒ ▒▒▒▒▒ ",
            ""
        }
        dashboard.section.header.opts.hl = "AlphaHeader"            --apply header highlight
        dashboard.section.buttons.val = {                           --define dashboard buttons
            dashboard.button("n",   "  New File",              ":enew<CR>"),
            dashboard.button("f",   "󰍉  Find File",             ":Telescope find_files<CR>"),
            dashboard.button("r",   "󰋚  Recently Opened Files", ":Telescope oldfiles<CR>"),
            dashboard.button("o",   "  Open Last Session",     ":silent source Session.vim<CR>"),
            dashboard.button("s",   " Sessions",              ":SessionManager<CR>"),
            dashboard.button("l",   "󰒲  Lazy",                  ":Lazy<CR>"),
            dashboard.button("q",   "󰅚  Quit",                  ":qa<CR>"),
        }
        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"                     --apply button highlight
            button.opts.hl_shortcut = "AlphaShortcut"           --apply shortcut highlight
        end
        local load_time = tostring(math.floor((require("lazy").stats().startuptime * 100 + 0.5) / 100))
        dashboard.section.footer.val = {                        --footer with load time
            "╔════════════════════════════════════════════════════════════════╗",
            "║              Welcome to Caesar James LEE's Neovim              ║",
            string.format("║                    Plugins loaded in %s ms                      ║", load_time),
            "╚════════════════════════════════════════════════════════════════╝",
        }
        dashboard.section.footer.opts.hl = "AlphaFooter"        --apply footer highlight

        --layout
        local opts = {
            layout = {
                { type = "padding", val = 2 },
                dashboard.section.header,
                { type = "padding", val = 3 },
                dashboard.section.buttons,
                { type = "padding", val = 2 },
                dashboard.section.footer,
            },
            opts = {
                margin = 5,
                redraw_on_resize = true,
                noautocmd = false,
            },
        }

        --apply config
        require("alpha").setup({
            layout = {
                {type = "padding", val = 2},                    --add padding above header
                dashboard.section.header,                       --display header
                {type = "padding", val = 3},                    --add padding between header and buttons
                dashboard.section.buttons,                      --display buttons
                {type = "padding", val = 2},                    --add padding below buttons
                dashboard.section.footer                        --display footer
            },
            opts = {margin = 5}                                 --set layout margin
        })

        --highlight groups
        vim.api.nvim_set_hl(0,  "AlphaHeader",      {fg = "#00ffff",    bold = true})
        vim.api.nvim_set_hl(0,  "AlphaButtons",     {fg = "#98c379",    bold = true})
        vim.api.nvim_set_hl(0,  "AlphaShortcut",    {fg = "#e5c07b",    italic = true})
        vim.api.nvim_set_hl(0,  "AlphaFooter",      {fg = "#f1502f",    bold = true })

        vim.api.nvim_create_autocmd("FileType", {               --hide UI elements for dashboard
            pattern = "alpha",
            callback = function()
                vim.opt_local.showtabline = 0                   --hide tabline in dashboard
                vim.opt_local.laststatus = 0                    --hide statusline in dashboard
            end
        })
        vim.api.nvim_create_autocmd("BufUnload", {              --restore statusline after closes
            pattern = "alpha",
            callback = function()
                vim.opt.laststatus = 3                          --restore global statusline after closing
            end
        })
    end
}
