local hl = function(name, opts) vim.api.nvim_set_hl(0, name, opts) end
return {
    --onedark colorscheme
    {
        "navarasu/onedark.nvim",
        priority = 900, --load before other plugins
        config = function()
            require("onedark").setup({
                style = "deep", --themes: dark, darker, cool, deep, warm, warmer
            })
            require("onedark").load() --apply colorscheme
            --base overrides
            local highlights = {
                LineNr = { fg = "#555555" }, --gray line numbers
                CursorLineNr = { fg = "#00fff7", bold = true }, --cyan bold current line number
                CursorLine = { bg = "#2b005e" }, --indigo cursor line
                CursorColumn = { bg = "#2b005e" }, --indigo cursor column
                Search = { fg = "#00fff7", bg = "#f5a623" }, --cyan search with alive background
                MsgArea = { fg = "#00fff7" }, --cyan message area
                MoreMsg = { fg = "#00fff7" }, --cyan more messages
                Question = { fg = "#00fff7" }, --cyan questions
                ModeMsg = { fg = "#00fff7" }, --cyan mode messages
                Cursor = { fg = "#ff1493" }, --pink cursor
            }
            for group, opts in pairs(highlights) do
                hl(group, opts)
            end

            --cyberpunk completion window
            local cyberpunk = {
                -- popup chrome
                CmpNormalFloat = { fg = "#00fff7", bg = "#0a001f" },
                CmpBorder = { fg = "#00fff7" },
                CmpDocBorder = { fg = "#ff62e5" },
                CmpSel = { fg = "#00fff7", bg = "#2b005e", bold = true },
                CmpItemMenu = { fg = "#555555", italic = true },
                CmpGhostText = { fg = "#555555", italic = true },

                -- kind icon colors (per LSP kind)
                CmpItemKindText = { fg = "#ffffff" },
                CmpItemKindFunction = { fg = "#ff00ff" },
                CmpItemKindMethod = { fg = "#ff00ff" },
                CmpItemKindConstructor = { fg = "#ff00ff" },
                CmpItemKindKeyword = { fg = "#ff00ff" },
                CmpItemKindOperator = { fg = "#ff00ff" },
                CmpItemKindClass = { fg = "#ff9500" },
                CmpItemKindInterface = { fg = "#ff9500" },
                CmpItemKindEnum = { fg = "#ff9500" },
                CmpItemKindStruct = { fg = "#ff9500" },
                CmpItemKindEvent = { fg = "#ff9500" },
                CmpItemKindEnumMember = { fg = "#ff9500" },
                CmpItemKindTypeParameter = { fg = "#ff9500" },
                CmpItemKindField = { fg = "#00ffff" },
                CmpItemKindProperty = { fg = "#00ffff" },
                CmpItemKindReference = { fg = "#00ffff" },
                CmpItemKindVariable = { fg = "#00e5ff" },
                CmpItemKindConstant = { fg = "#ff4444" },
                CmpItemKindColor = { fg = "#ff4444" },
                CmpItemKindSnippet = { fg = "#ffe600" },
                CmpItemKindModule = { fg = "#ffe600" },
                CmpItemKindUnit = { fg = "#ffe600" },
                CmpItemKindValue = { fg = "#00ff88" },
                CmpItemKindFile = { fg = "#aaaaaa" },
                CmpItemKindFolder = { fg = "#aaaaaa" },
            }
            for group, opts in pairs(cyberpunk) do
                hl(group, opts)
            end
        end,
    },
    --git signs
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "󰐖" },
                    change = { text = "󱗜" },
                    delete = { text = "󰍵" },
                    topdelete = { text = "󰾟" },
                    changedelete = { text = "󰦓" },
                    untracked = { text = "󰏬" },
                },
            })

            hl("GitSignsAdd", { fg = "#98c379" })
            hl("GitSignsChange", { fg = "#e5c07b" })
            hl("GitSignsDelete", { fg = "#e06c75" })
            hl("GitSignsTopdelete", { fg = "#e06c75" })
            hl("GitSignsChangedelete", { fg = "#e5c07b" })
            hl("GitSignsUntracked", { fg = "#00ffff" })
        end,
    },
    --status line
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons", --file icons
            "lewis6991/gitsigns.nvim", --gitsigns
        },
        config = function()
            local is_wide = function() return vim.api.nvim_get_option_value("columns", {}) >= 130 end

            -- git diff counts from gitsigns
            local git_count = function(key, icon)
                return function()
                    local d = vim.b.gitsigns_status_dict
                    local n = d and d[key] or 0
                    return n > 0 and string.format("%s %d", icon, n) or ""
                end
            end

            -- LSP diagnostic counts
            local diag_count = function(severity, icon)
                return function()
                    local n = #vim.diagnostic.get(0, { severity = severity })
                    return n > 0 and string.format("%s %d", icon, n) or ""
                end
            end

            local sev = vim.diagnostic.severity
            local WEEK = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" }
            local MONTH = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }

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
                            "snacks",
                            "snacks_dashboard",
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
                    },
                    lualine_c = {
                        { git_count("added", ""), color = { fg = "#98c379" } },
                        { git_count("removed", ""), color = { fg = "#e06c75" } },
                        { git_count("changed", ""), color = { fg = "#e5c07b" } },
                        { diag_count(sev.ERROR, ""), color = { fg = "#e06c75" } },
                        { diag_count(sev.WARN, ""), color = { fg = "#e5c07b" } },
                        {
                            function() return is_wide() and diag_count(sev.HINT, "󰌵")() or "" end,
                            color = { fg = "#645394" },
                        },
                        {
                            function() return is_wide() and diag_count(sev.INFO, "")() or "" end,
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
                            function()
                                return string.format(" %d/%d", vim.fn.col("."), math.max(1, vim.fn.col("$") - 1))
                            end,
                            color = { fg = "#f65314", bg = "#7cbb00" },
                        },
                    },
                    lualine_z = {
                        {
                            function()
                                local t = os.date("*t")
                                local pm = t.hour >= 12 and "pm" or "am"
                                local h = t.hour % 12
                                if h == 0 then h = 12 end
                                if is_wide() then
                                    return string.format(
                                        "🕗 %s %s/%02d/%02d %02d:%02d:%02d %s",
                                        WEEK[t.wday],
                                        MONTH[t.month],
                                        t.day,
                                        t.year % 100,
                                        h,
                                        t.min,
                                        t.sec,
                                        pm
                                    )
                                end
                                return string.format("🕗 %02d:%02d:%02d", t.hour, t.min, t.sec)
                            end,
                            color = { fg = "#ffffff", bg = "#282c34" },
                        },
                    },
                },
            })
        end,
    },
    --buffer line
    {
        "akinsho/bufferline.nvim",
        version = "*",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
                    themable = true,
                    numbers = "ordinal",
                    indicator = {
                        style = "underline",
                    },
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    separator_style = "slant", --trapezoid border
                    modified_icon = "󱦹",
                    diagnostics = "nvim_lsp",
                    color_icons = true,
                    -- sort by most recently used
                    sort_by = function(a, b)
                        local info_a = vim.fn.getbufinfo(a.id)[1] or {}
                        local info_b = vim.fn.getbufinfo(b.id)[1] or {}
                        return (info_a.lastused or 0) > (info_b.lastused or 0)
                    end,
                },
            })
        end,
    },
    --file icons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
        config = function()
            -- converts HEX → nearest cterm 256 color index
            local function hex_to_cterm(hex)
                if #hex ~= 7 then return 0 end
                local r = tonumber(hex:sub(2, 3), 16)
                local g = tonumber(hex:sub(4, 5), 16)
                local b = tonumber(hex:sub(6, 7), 16)
                local function n(x) return math.floor(x / 255 * 5 + 0.5) end
                return 16 + n(r) * 36 + n(g) * 6 + n(b)
            end

            local function icon(i, color, name)
                return { icon = i, color = color, cterm_color = hex_to_cterm(color), name = name }
            end

            require("nvim-web-devicons").setup({
                override = {
                    -- === system & native ===
                    ["bat"] = icon("", "#0078D4", "Bat"),
                    ["exe"] = icon("", "#0078D4", "Exe"),
                    ["lib"] = icon("", "#4D2C0B", "Lib"),
                    ["o"] = icon("", "#9F0500", "ObjectFile"),
                    ["out"] = icon("", "#9F0500", "Out"),
                    ["download"] = icon("󰇚", "#44CDA8", "Download"),
                    ["iso"] = icon("", "#D0BEC8", "Iso"),
                    ["img"] = icon("", "#D0BEC8", "Img"),
                    ["image"] = icon("", "#D0BEC8", "Image"),
                    ["log"] = icon("", "#DDDDDD", "Log"),
                    ["env"] = icon("", "#FBBC05", "Env"),
                    [".env"] = icon("", "#FBBC05", "Environment"),

                    -- === C / C++ ===
                    ["c++"] = icon("", "#00599C", "CPlusPlus"),
                    ["cp"] = icon("", "#00599C", "Cp"),
                    ["cpp"] = icon("", "#00599C", "Cpp"),
                    ["cppm"] = icon("", "#00599C", "Cppm"),
                    ["cxx"] = icon("", "#00599C", "Cxx"),
                    ["cxxm"] = icon("", "#00599C", "Cxxm"),
                    ["ixx"] = icon("", "#00599C", "Ixx"),
                    ["mpp"] = icon("", "#00599C", "Mpp"),
                    ["h"] = icon("", "#00599C", "H"),
                    ["hh"] = icon("", "#00599C", "Hh"),
                    ["hpp"] = icon("", "#00599C", "Hpp"),
                    ["hxx"] = icon("", "#00599C", "Hxx"),

                    -- === Java ===
                    ["java"] = icon("", "#ED8B00", "Java"),
                    ["jar"] = icon("", "#007396", "Jar"),
                    ["gradle"] = icon("", "#06A0CE", "Gradle"),
                    [".mvn"] = icon("", "#FF6804", "MavenProject"),
                    ["mvnw"] = icon("", "#FF6804", "MavenProject"),
                    ["pom.xml"] = icon("", "#FF6804", "MavenDependencies"),
                    ["application.properties"] = icon("", "#6DB33F", "SpringBootEnterPoint"),
                    ["application.yml"] = icon("", "#6DB33F", "SpringBootEnterPoint"),

                    -- === Python ===
                    ["py"] = icon("", "#FFE873", "Py"),
                    ["pyc"] = icon("", "#FFE873", "Pyc"),
                    ["pyd"] = icon("", "#FFE873", "Pyd"),
                    ["pyi"] = icon("", "#FFE873", "Pyi"),
                    ["pyo"] = icon("", "#FFE873", "Pyo"),
                    ["pyw"] = icon("", "#FFE873", "Pyw"),
                    ["pyx"] = icon("", "#FFE873", "Pyx"),
                    ["pxd"] = icon("", "#FFE873", "Pxd"),
                    ["pxi"] = icon("", "#FFE873", "Pxi"),

                    -- === Lua ===
                    ["lua"] = icon("", "#1564C0", "Lua"),
                    ["luac"] = icon("", "#1564C0", "Lua"),
                    ["luau"] = icon("", "#1564C0", "Luau"),

                    -- === Web ===
                    ["html"] = icon("", "#E34C26", "Html"),
                    ["http"] = icon("󰖟", "#008EC7", "HTTP"),
                    ["css"] = icon("", "#264DE4", "Css"),
                    ["sass"] = icon("", "#CC6699", "Sass"),
                    ["scss"] = icon("", "#E74C3C", "Scss"),
                    ["less"] = icon("", "#CC6699", "Less"),
                    ["js"] = icon("", "#F0DB4F", "Js"),
                    ["jsx"] = icon("", "#0081A3", "Jsx"),
                    ["mjs"] = icon("", "#F0DB4F", "Mjs"),
                    ["cjs"] = icon("", "#F0DB4F", "Cjs"),
                    ["ts"] = icon("", "#007ACC", "TypeScript"),
                    ["tsx"] = icon("", "#0081A3", "Tsx"),
                    ["mts"] = icon("", "#519ABA", "Mts"),
                    ["cts"] = icon("", "#007ACC", "Cts"),
                    ["vue"] = icon("", "#41B883", "Vue"),
                    ["graphql"] = icon("", "#E10098", "GraphQL"),

                    -- === data / config ===
                    ["json"] = icon("", "#CBCB41", "Json"),
                    ["json5"] = icon("", "#CBCB41", "Json5"),
                    ["jsonc"] = icon("", "#CBCB41", "Jsonc"),
                    ["yaml"] = icon("", "#FFA124", "Yaml"),
                    ["yml"] = icon("", "#FFA124", "Yml"),
                    ["xml"] = icon("", "#E44B4D", "Xml"),
                    ["toml"] = icon("", "#E44B4D", "Toml"),
                    ["csv"] = icon("", "#4DB6AC", "Csv"),
                    ["tsv"] = icon("", "#4DB6AC", "Tsv"),
                    ["sql"] = icon("", "#195BBB", "Sql"),
                    ["sqlite"] = icon("", "#195BBB", "Sqlite"),
                    ["sqlite3"] = icon("", "#195BBB", "sqlite3"),

                    -- === docs ===
                    ["md"] = icon("", "#42A5F5", "Md"),
                    ["mdx"] = icon("", "#42A5F5", "Mdx"),
                    ["markdown"] = icon("", "#42A5F5", "Markdown"),
                    ["tex"] = icon("", "#FFFFFF", "Tex"),
                    ["pdf"] = icon("", "#E5252A", "Pdf"),
                    ["doc"] = icon("", "#41A5EE", "Doc"),
                    ["docx"] = icon("", "#41A5EE", "Docx"),
                    ["xls"] = icon("󱎏", "#1d6f42", "Els"),
                    ["xlsx"] = icon("󱎏", "#1d6f42", "Elsx"),
                    ["ppt"] = icon("󱎐", "#D04423", "Ppt"),
                    ["pptx"] = icon("󱎐", "#CB4A32", "Pptx"),

                    -- === media / fonts ===
                    ["ttf"] = icon("", "#886CC4", "TrueTypeFont"),
                    ["woff"] = icon("", "#886CC4", "WebOpenFontFormat"),
                    ["woff2"] = icon("", "#886CC4", "WebOpenFontFormat"),
                    ["psb"] = icon("", "#31A8FF", "Psb"),
                    ["psd"] = icon("", "#31A8FF", "Psd"),
                    ["material"] = icon("", "#B83998", "Material"),

                    -- === devops ===
                    ["dockerignore"] = icon("", "#1D63ED", "DockerIgnore"),

                    -- === IDE / projects
                    ["sln"] = icon("", "#6A1B9A", "Sln"),
                    ["slnx"] = icon("", "#6A1B9A", "Slnx"),
                    ["suo"] = icon("", "#6A1B9A", "Suo"),
                    ["vsix"] = icon("", "#6A1B9A", "Vsix"),
                    [".vscode"] = icon("", "#0078D7", "VscodeProject"),
                    [".idea"] = icon("", "#B1428A", "IntelliJProject"),
                    [".project"] = icon("", "#2c2255", "Project"),
                    [".classpath"] = icon("", "#2c2255", "Classpath"),
                    [".settings"] = icon("", "#2c2255", "Settings"),

                    -- === QT ===
                    ["qml"] = icon("", "#41CD52", "Qt"),
                    ["qrc"] = icon("", "#41CD52", "Qt"),
                    ["qss"] = icon("", "#41CD52", "Qt"),

                    -- === misc ===
                    ["exs"] = icon("", "#A074C4", "Exs"),
                    ["vim"] = icon("", "#019733", "Vim"),
                    ["desktop"] = icon("", "#563D7C", "DesktopEntry"),
                    ["import"] = icon("󰈠", "#ECECEC", "ImportConfiguration"),
                    ["license"] = icon("󰿃", "#CBCB41", "License"),

                    -- === git ===
                    ["git"] = icon("", "#F1502F", "GitLogo"),
                    [".git"] = icon("", "#F1502F", "GitConfig"),
                    [".gitignore"] = icon("", "#F1502F", "GitIgnore"),

                    -- === node ===
                    ["node_modules"] = icon("", "#FF6804", "NodeModules"),

                    -- === formatters / linters
                    [".clang-format"] = icon("", "#0D5D6C", "ClangFormat"),
                    ["_clang-format"] = icon("", "#0D5D6C", "ClangFormat"),
                    ["clang-format"] = icon("", "#0D5D6C", "ClangFormat"),
                    ["stylua.toml"] = icon("", "#1564C0", "Stylua"),
                    [".prettierrc"] = icon("", "#F08B9C", "Prettier"),
                    [".prettierrc.json"] = icon("", "#F08B9C", "Prettier"),
                    [".prettierrc.yml"] = icon("", "#F08B9C", "Prettier"),
                    [".prettierrc.yaml"] = icon("", "#F08B9C", "Prettier"),
                    [".prettierrc.json5"] = icon("", "#F08B9C", "Prettier"),
                    [".prettierrc.js"] = icon("", "#F08B9C", "Prettier"),
                    [".prettierrc.ts"] = icon("", "#F08B9C", "Prettier"),
                    ["prettier.config.js"] = icon("", "#F08B9C", "Prettier"),
                    ["prettier.config.ts"] = icon("", "#F08B9C", "Prettier"),
                    [".prettierrc.mjs"] = icon("", "#F08B9C", "Prettier"),
                    [".prettierrc.mts"] = icon("", "#F08B9C", "Prettier"),
                    ["prettier.config.mjs"] = icon("", "#F08B9C", "Prettier"),
                    ["prettier.config.mts"] = icon("", "#F08B9C", "Prettier"),
                    [".prettierrc.cjs"] = icon("", "#F08B9C", "Prettier"),
                    [".prettierrc.cts"] = icon("", "#F08B9C", "Prettier"),
                    ["prettier.config.cjs"] = icon("", "#F08B9C", "Prettier"),
                    ["prettier.config.cts"] = icon("", "#F08B9C", "Prettier"),
                    [".prettierrc.toml"] = icon("", "#F08B9C", "Prettier"),

                    -- === test / storybook
                    ["spec.js"] = icon("󰙨", "#F0DB4F", "SpecJs"),
                    ["spec.jsx"] = icon("󰙨", "#0081A3", "JavaScriptReactSpec"),
                    ["spec.ts"] = icon("󰙨", "#007ACC", "SpecTs"),
                    ["spec.tsx"] = icon("󰙨", "#0081A3", "TypeScriptReactSpec"),
                    ["stories.js"] = icon("󱩵", "#F0DB4F", "StorybookJavaScript"),
                    ["stories.jsx"] = icon("󱩵", "#0081A3", "StorybookJsx"),
                    ["stories.mjs"] = icon("󱩵", "#FF4785", "StorybookMjs"),
                    ["stories.svelte"] = icon("󱩵", "#FF4785", "StorybookSvelte"),
                    ["stories.ts"] = icon("󱩵", "#007ACC", "StorybookTypeScript"),
                    ["stories.tsx"] = icon("󱩵", "#0081A3", "StorybookTsx"),
                    ["stories.vue"] = icon("󱩵", "#41B883", "StorybookVue"),
                    ["test.js"] = icon("", "#F0DB4F", "TestJs"),
                    ["test.jsx"] = icon("", "#0081A3", "JavaScriptReactTest"),
                    ["test.ts"] = icon("", "#007ACC", "TestTs"),
                    ["test.tsx"] = icon("", "#0081A3", "TypeScriptReactTest"),
                },
                default = true,
            })
        end,
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = true },
            words = { enabled = true },

            --dashboard
            dashboard = {
                enabled = true,
                width = 50,
                preset = {
                    header = [[
╭───────────────────────────────────────────────────────────────────╮
│   █████████     ██████   █████ █████   █████  ███                 │
│  ███▒▒▒▒▒███   ▒▒██████ ▒▒███ ▒▒███   ▒▒███  ▒▒▒                  │
│ ███     ▒▒▒     ▒███▒███ ▒███  ▒███    ▒███  ████  █████████████  │
│▒███             ▒███▒▒███▒███  ▒███    ▒███ ▒▒███ ▒▒███▒▒███▒▒███ │
│▒███             ▒███ ▒▒██████  ▒▒███   ███   ▒███  ▒███ ▒███ ▒███ │
│▒▒███     ███    ▒███  ▒▒█████   ▒▒▒█████▒    ▒███  ▒███ ▒███ ▒███ │
│ ▒▒█████████     █████  ▒▒█████    ▒▒███      █████ █████▒███ █████│
│  ▒▒▒▒▒▒▒▒▒     ▒▒▒▒▒    ▒▒▒▒▒      ▒▒▒      ▒▒▒▒▒ ▒▒▒▒▒ ▒▒▒ ▒▒▒▒▒ │
│                                                                   │
│                Welcome To Caesar James LEE's Neovim               │
╰───────────────────────────────────────────────────────────────────╯
                    ]],
                    keys = {
                        { icon = "󰈔", key = "n", desc = "New File", action = ":ene | startinsert" },
                        {
                            icon = "󰈞",
                            key = "f",
                            desc = "Find File",
                            action = ":lua Snacks.dashboard.pick('files')",
                        },
                        {
                            icon = "󰊄",
                            key = "t",
                            desc = "Find Text",
                            action = ":lua Snacks.dashboard.pick('live_grep')",
                        },
                        {
                            icon = "󱋡",
                            key = "r",
                            desc = "Recent Files",
                            action = ":lua Snacks.dashboard.pick('oldfiles')",
                        },
                        {
                            icon = "󱁿",
                            key = "c",
                            desc = "Config",
                            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                        },
                        {
                            icon = "󰥨",
                            key = "F",
                            desc = "Find Sessions",
                            action = ":lua Snacks.picker.projects()",
                        },
                        {
                            icon = "",
                            key = "o",
                            desc = "Open Session of CWD",
                            action = ":lua Snacks.picker.projects()",
                        },
                        { icon = "󰒲", key = "l", desc = "Lazy", action = ":Lazy" },
                        { icon = "󰅙", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 3 },
                    {
                        pane = 2,
                        icon = "󰈢",
                        title = "Recent Buffers",
                        section = "recent_files",
                        indent = 4,
                        padding = 3,
                        gap = 1,
                    },
                    {
                        pane = 2,
                        icon = "󰉓",
                        title = "Recent Projects",
                        section = "projects",
                        indent = 4,
                        padding = 3,
                        gap = 1,
                    },
                    { pane = 2, section = "startup" },
                },
            },
        },
        keys = {
            --history
            { "<leader>hc", function() Snacks.picker.command_history() end, desc = "command history" },
            { "<leader>hn", function() Snacks.picker.notifications() end, desc = "notification history" },
            { "<leader>hs", function() Snacks.picker.search_history() end, desc = "search history" },
            { "<leader>hu", function() Snacks.picker.undo() end, desc = "undo history" },

            --find
            { "<leader>ff", function() Snacks.picker.files() end, desc = "find files" },
            { "<leader>ft", function() Snacks.picker.grep() end, desc = "find text in session" },
            { "<leader>fT", function() Snacks.picker.grep_buffers() end, desc = "find text in opened buffers" },
            { "<leader>fl", function() Snacks.picker.lines() end, desc = "find buffer lines" },
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "find buffers" },
            { "<leader>fr", function() Snacks.picker.registers() end, desc = "find registers" },
            { "<leader>fm", function() Snacks.picker.marks() end, desc = "find marks" },
            { "<leader>fj", function() Snacks.picker.jumps() end, desc = "find jumps" },
            { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "find keymaps" },
            { "<leader>fh", function() Snacks.picker.help() end, desc = "find helps" },
            { "<leader>fH", function() Snacks.picker.highlights() end, desc = "find highlights" },
            { "<leader>fi", function() Snacks.picker.icons() end, desc = "find icons" },
            { "<leader>fc", function() Snacks.picker.commands() end, desc = "find commands" },
            { "<leader>fa", function() Snacks.picker.autocmds() end, desc = "find autocmds" },
            { "<leader>fp", function() Snacks.picker.lazy() end, desc = "find plugins" },
            { "<leader>fq", function() Snacks.picker.qflist() end, desc = "find quickfixs" },
            { "<leader>fL", function() Snacks.picker.loclist() end, desc = "find location list" },
            { "<leader>fR", function() Snacks.picker.resume() end, desc = "find resume" },
            { "<leader>fC", function() Snacks.picker.colorschemes() end, desc = "find colorschemes" },
            { "<leader>fd", function() Snacks.picker.diagnostics_buffer() end, desc = " find buffer diagnostics" },
            { "<leader>fD", function() Snacks.picker.diagnostics() end, desc = "find session diagnostics" },
            { "<leader>fs", function() Snacks.picker.projects() end, desc = "find sessions" },
            {
                "<leader>fn",
                function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
                desc = "find neovim config files",
            },

            -- git
            { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "git branches" },
            { "<leader>gl", function() Snacks.picker.git_log() end, desc = "git log" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "git status" },
            {
                "<leader>gB",
                function() Snacks.gitbrowse() end,
                desc = "git browse",
                mode = { "n", "v" },
            },
            { "<leader>gL", function() Snacks.lazygit() end, desc = "lazygit" },

            -- LSP
            { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto LSP type definition" },
            { "gc", function() Snacks.picker.lsp_incoming_calls() end, desc = "goto incoming calls" },
            { "gC", function() Snacks.picker.lsp_outgoing_calls() end, desc = "goto outgoing calls" },
            { "gs", function() Snacks.picker.lsp_symbols() end, desc = "find document LSP Symbols" },
            { "gS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "find Workspace LSP Symbols" },

            --toggles
            { "<leader>tz", function() Snacks.zen() end, desc = "toggle zen mode" },
            { "<leader>tZ", function() Snacks.zen.zoom() end, desc = "toggle zoom mode" },
            {
                "<leader>tt",
                function() Snacks.terminal(vim.fn.has("win32") == 1 and "pwsh -NoLogo" or nil) end,
                desc = "toggle terminal",
            },

            --buffers
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "delete buffer" },
            { "<leader>br", function() Snacks.rename.rename_file() end, desc = "rename buffer" },

            --other
            { "<leader>dn", function() Snacks.notifier.hide() end, desc = "dismiss all notifications" },
            {
                "[r",
                function() Snacks.words.jump(-vim.v.count1) end,
                desc = "prev reference",
                mode = { "n", "t" },
            },
            {
                "]r",
                function() Snacks.words.jump(vim.v.count1) end,
                desc = "next reference",
                mode = { "n", "t" },
            },
            {
                "<leader>nn",
                function()
                    Snacks.win({
                        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                        width = 0.8,
                        height = 0.7,
                        wo = {
                            spell = false,
                            wrap = false,
                            signcolumn = "yes",
                            statuscolumn = " ",
                            conceallevel = 3,
                        },
                    })
                end,
                desc = "neovim news",
            },
        },
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        keys = {
            {
                "<F2>",
                "<cmd>Trouble symbols toggle focus=true<cr>",
                desc = "toggle LSP symbols",
            },
            {
                "<S-F2>",
                "<cmd>Trouble lsp toggle focus=true<cr>",
                desc = "toggle LSP panel",
            },
            {
                "<C-F2>",
                "<cmd>Trouble diagnostics toggle focus=true<cr>",
                desc = "toggle buffer LSP diagnostics",
            },
        },
        opts = {
            use_diagnostic_signs = true,
            auto_preview = false,
            auto_close = true,
            focus = true,
            win = {
                type = "split",
                position = "right",
                size = 100,
            },
            keys = {
                ["<cr>"] = "jump_close",
                ["<2-leftmouse>"] = false,
                ["<leftmouse>"] = false,
                ["d"] = "delete",
                ["dd"] = false,
                ["<c-s>"] = false,
                ["h"] = "jump_split",
                ["<c-v>"] = false,
                ["v"] = "jump_vsplit",
                ["}"] = false,
                ["]]"] = false,
                ["{"] = false,
                ["[["] = false,
                ["o"] = "fold_open",
                ["O"] = "fold_open_recursive",
                ["c"] = "fold_close",
                ["C"] = "fold_close_recursive",
                ["x"] = "fold_toggle",
                ["X"] = "fold_toggle_recursive",
            },
            action_keys = {
                jump_split_close = {},
            },
            modes = {
                preview_float = {
                    mode = "diagnostics",
                    preview = {
                        type = "float",
                        relative = "editor",
                        border = "rounded",
                        title = "Trouble Preview",
                        title_pos = "center",
                        position = { 0, -2 },
                        size = { width = 0.3, height = 0.3 },
                        zindex = 210,
                    },
                },
            },
        },
    },
}
