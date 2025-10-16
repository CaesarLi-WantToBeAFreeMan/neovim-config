-- startup greeter
return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        --ASCII banner
        local banner = {
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
        }

        dashboard.section.header.val = banner
        dashboard.section.header.opts.hl = "AlphaHeader"

        --menu buttons
        dashboard.section.buttons.val = {
            dashboard.button("n",   "  New file",              ":enew<CR>"),
            dashboard.button("f",   "󰍉  Find file",             ":Telescope find_files<CR>"),
            dashboard.button("r",   "󰋚  Recently opened files", ":Telescope oldfiles<CR>"),
            dashboard.button("o",   "  Open last session",     ":silent source Session.vim<CR>"),
            dashboard.button("s",   " Sessions",              ":SessionManager<CR>"),
            dashboard.button("l",   "󰒲  Lazy",                  ":Lazy<CR>"),
            dashboard.button("q",   "󰅚  Quit",                  ":qa<CR>"),
        }

        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
        end

        --plugin load time
        local function get_plugin_load_time()
            return tostring(
                math.floor(
                    (require("lazy").stats().startuptime * 100 + 0.5) / 100
                )
            )
        end

        --footer
        local load_time = get_plugin_load_time()
        dashboard.section.footer.val = {
            "╔════════════════════════════════════════════════════════════════╗",
            "║              Welcome to Caesar James LEE's Neovim              ║",
            string.format("║                    Plugins loaded in %s ms                      ║", load_time),
            "╚════════════════════════════════════════════════════════════════╝",
        }
        dashboard.section.footer.opts.hl = "AlphaFooter"

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
        alpha.setup(opts)

        --highlight groups
        local set_hl = vim.api.nvim_set_hl
        set_hl(0, "AlphaHeader", { fg = "#00ffff", bold = true })
        set_hl(0, "AlphaButtons", { fg = "#98c379", bold = true })
        set_hl(0, "AlphaShortcut", { fg = "#e5c07b", italic = true })
        set_hl(0, "AlphaFooter", {fg = "#f1502f", bold = true })

        --hide UI elements while Alpha is open
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "alpha",
            callback = function()
                vim.opt_local.showtabline = 0
                vim.opt_local.laststatus = 0
            end,
        })

        --restore statusline after Alpha closes
        vim.api.nvim_create_autocmd("BufUnload", {
            pattern = "alpha",
            callback = function()
                vim.opt.laststatus = 3
            end,
        })
    end,
}
