return {
    --onedark colorscheme
    {
        "navarasu/onedark.nvim",
        priority = 1000, --load before other plugins
        config = function()
            require("onedark").setup({
                style = "deep", --themes: dark, darker, cool, deep, warm, warmer
            })
            require("onedark").load() --apply colorscheme
            local highlights = {
                LineNr = { fg = "#ffffff", bg = "NONE" }, --white line numbers
                CursorLineNr = { fg = "#00ffff", bg = "NONE", bold = true }, --cyan bold current line number
                CursorLine = { bg = "#333333" }, --dark gray cursor line
                CursorColumn = { bg = "#333333" }, --dark cray cursor column
                Search = { fg = "#00ffff", bg = "#756a22" }, --cyan search with alive background
                MsgArea = { fg = "#00ffff" }, --cyan message area
                MoreMsg = { fg = "#00ffff" }, --cyan more messages
                Question = { fg = "#00ffff" }, --cyan questions
                ModeMsg = { fg = "#00ffff" }, --cyan mode messages
                Cursor = { fg = "#ff0000" }, --red cursor
            }
            for group, settings in pairs(highlights) do
                vim.api.nvim_set_hl(0, group, settings) --apply highlight overrides
            end
        end,
    },
    --git signs
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local hl = vim.api.nvim_set_hl
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

            hl(0, "GitSignsAdd", { fg = "#98c379" })
            hl(0, "GitSignsChange", { fg = "#e5c07b" })
            hl(0, "GitSignsDelete", { fg = "#e06c75" })
            hl(0, "GitSignsTopdelete", { fg = "#e06c75" })
            hl(0, "GitSignsChangedelete", { fg = "#e5c07b" })
            hl(0, "GitSignsUntracked", { fg = "#00ffff" })
        end,
    },
    --status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons", --file icons
            "lewis6991/gitsigns.nvim", --gitsigns
        },
        event = { "BufReadPost", "BufNewFile" },
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
                local icon = type == "error" and ""
                    or type == "warning" and ""
                    or type == "hint" and "󰌵"
                    or ""
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
                                        { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" },
                                        t.hour < 12 and "am" or "pm"
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
    },
    --buffer line
    {
        "akinsho/bufferline.nvim",
        version = "*",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
                    numbers = "both",
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    indicator = {
                        icon = "✝️",
                        style = "icon",
                    },
                    max_name_length = 21,
                    max_prefix_length = 18,
                    tab_size = 21,
                },
            })
        end,
    },
    --file icons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        config = function()
            local override_icon_color_name = function(icon, color, name)
                local cterm_color
                if #color ~= 7 then
                    cterm_color = "0"
                else
                    local red, green, blue =
                        tonumber(color:sub(2, 3), 16), tonumber(color:sub(4, 5), 16), tonumber(color:sub(6, 7), 16)
                    local cterm_red, cterm_green, cterm_blue =
                        math.floor((red / 255) * 5 + 0.5),
                        math.floor((green / 255) * 5 + 0.5),
                        math.floor((blue / 255) * 5 + 0.5)
                    cterm_color = 16 + (cterm_red * 36) + (cterm_green * 6) + cterm_blue
                end

                return {
                    icon = icon,
                    color = color,
                    cterm_color = cterm_color,
                    name = name,
                }
            end

            require("nvim-web-devicons").setup({
                override = {
                    ["bat"] = override_icon_color_name("", "#0078D4", "Bat"),
                    ["c++"] = override_icon_color_name("", "#00599C", "CPlusPlus"),
                    ["cp"] = override_icon_color_name("", "#00599C", "Cp"),
                    ["cpp"] = override_icon_color_name("", "#00599C", "Cpp"),
                    ["cppm"] = override_icon_color_name("", "#00599C", "Cppm"),
                    ["css"] = override_icon_color_name("", "#264DE4", "Css"),
                    ["csv"] = override_icon_color_name("", "#4DB6AC", "Csv"),
                    ["cts"] = override_icon_color_name("", "#007ACC", "Cts"),
                    ["cxx"] = override_icon_color_name("", "#00599C", "Cxx"),
                    ["cxxm"] = override_icon_color_name("", "#00599C", "Cxxm"),
                    ["desktop"] = override_icon_color_name("", "#563D7C", "DesktopEntry"),
                    ["doc"] = override_icon_color_name("", "#41A5EE", "Doc"),
                    ["dockerignore"] = override_icon_color_name("", "#1D63ED", "DockerIgnore"),
                    ["docx"] = override_icon_color_name("", "#41A5EE", "Docx"),
                    ["download"] = override_icon_color_name("󰇚", "#44CDA8", "Download"),
                    ["env"] = override_icon_color_name("", "#FAF743", "Env"),
                    ["exe"] = override_icon_color_name("", "#0078D4", "Exe"),
                    ["exs"] = override_icon_color_name("", "#A074C4", "Exs"),
                    ["git"] = override_icon_color_name("", "#F1502F", "GitLogo"),
                    ["gradle"] = override_icon_color_name("", "#06A0CE", "Gradle"),
                    ["graphql"] = override_icon_color_name("", "#E10098", "GraphQL"),
                    ["h"] = override_icon_color_name("", "#00599C", "H"),
                    ["hh"] = override_icon_color_name("", "#00599C", "Hh"),
                    ["hpp"] = override_icon_color_name("", "#00599C", "Hpp"),
                    ["html"] = override_icon_color_name("", "#E34C26", "Html"),
                    ["http"] = override_icon_color_name("󰖟", "#008EC7", "HTTP"),
                    ["hxx"] = override_icon_color_name("", "#00599C", "Hxx"),
                    ["image"] = override_icon_color_name("", "#D0BEC8", "Image"),
                    ["img"] = override_icon_color_name("", "#D0BEC8", "Img"),
                    ["import"] = override_icon_color_name("󰈠", "#ECECEC", "ImportConfiguration"),
                    ["iso"] = override_icon_color_name("", "#D0BEC8", "Iso"),
                    ["ixx"] = override_icon_color_name("", "#00599C", "Ixx"),
                    ["jar"] = override_icon_color_name("", "#007396", "Jar"),
                    ["java"] = override_icon_color_name("", "#ED8B00", "Java"),
                    ["js"] = override_icon_color_name("", "#F0DB4F", "Js"),
                    ["json"] = override_icon_color_name("", "#CBCB41", "Json"),
                    ["json5"] = override_icon_color_name("", "#CBCB41", "Json5"),
                    ["jsonc"] = override_icon_color_name("", "#CBCB41", "Jsonc"),
                    ["jsx"] = override_icon_color_name("", "#0081A3", "Jsx"),
                    ["lib"] = override_icon_color_name("", "#4D2C0B", "Lib"),
                    ["license"] = override_icon_color_name("󰿃", "#CBCB41", "License"),
                    ["log"] = override_icon_color_name("", "#DDDDDD", "Log"),
                    ["lua"] = override_icon_color_name("", "#1564C0", "Lua"),
                    ["luac"] = override_icon_color_name("", "#1564C0", "Lua"),
                    ["luau"] = override_icon_color_name("", "#1564C0", "Luau"),
                    ["markdown"] = override_icon_color_name("", "#42A5F5", "Markdown"),
                    ["material"] = override_icon_color_name("", "#B83998", "Material"),
                    ["md"] = override_icon_color_name("", "#42A5F5", "Md"),
                    ["mdx"] = override_icon_color_name("", "#42A5F5", "Mdx"),
                    ["mjs"] = override_icon_color_name("", "#F0DB4F", "Mjs"),
                    ["mpp"] = override_icon_color_name("", "#00599C", "Mpp"),
                    ["mts"] = override_icon_color_name("", "#519ABA", "Mts"),
                    ["o"] = override_icon_color_name("", "#9F0500", "ObjectFile"),
                    ["out"] = override_icon_color_name("", "#9F0500", "Out"),
                    ["pdf"] = override_icon_color_name("", "#E5252A", "Pdf"),
                    ["ppt"] = override_icon_color_name("󱎐", "#D04423", "Ppt"),
                    ["pptx"] = override_icon_color_name("󱎐", "#CB4A32", "Pptx"),
                    ["psb"] = override_icon_color_name("", "#31A8FF", "Psb"),
                    ["psd"] = override_icon_color_name("", "#31A8FF", "Psd"),
                    ["pxd"] = override_icon_color_name("", "#FFE873", "Pxd"),
                    ["pxi"] = override_icon_color_name("", "#FFE873", "Pxi"),
                    ["py"] = override_icon_color_name("", "#FFE873", "Py"),
                    ["pyc"] = override_icon_color_name("", "#FFE873", "Pyc"),
                    ["pyd"] = override_icon_color_name("", "#FFE873", "Pyd"),
                    ["pyi"] = override_icon_color_name("", "#FFE873", "Pyi"),
                    ["pyo"] = override_icon_color_name("", "#FFE873", "Pyo"),
                    ["pyw"] = override_icon_color_name("", "#FFE873", "Pyw"),
                    ["pyx"] = override_icon_color_name("", "#FFE873", "Pyx"),
                    ["qml"] = override_icon_color_name("", "#41CD52", "Qt"),
                    ["qrc"] = override_icon_color_name("", "#41CD52", "Qt"),
                    ["qss"] = override_icon_color_name("", "#41CD52", "Qt"),
                    ["sass"] = override_icon_color_name("", "#CC6699", "Sass"),
                    ["scss"] = override_icon_color_name("", "#E74C3C", "Scss"),
                    ["sln"] = override_icon_color_name("", "#6A1B9A", "Sln"),
                    ["slnx"] = override_icon_color_name("", "#6A1B9A", "Slnx"),
                    ["suo"] = override_icon_color_name("", "#6A1B9A", "Suo"),
                    ["vsix"] = override_icon_color_name("", "#6A1B9A", "Vsix"),
                    ["sql"] = override_icon_color_name("", "#195BBB", "Sql"),
                    ["sqlite"] = override_icon_color_name("", "#195BBB", "Sql"),
                    ["sqlite3"] = override_icon_color_name("", "#195BBB", "Sql"),
                    ["tex"] = override_icon_color_name("", "#FFFFFF", "Tex"),
                    ["ts"] = override_icon_color_name("", "#007ACC", "TypeScript"),
                    ["tsx"] = override_icon_color_name("", "#0081A3", "Tsx"),
                    ["ttf"] = override_icon_color_name("", "#886CC4", "TrueTypeFont"),
                    ["vim"] = override_icon_color_name("", "#019733", "Vim"),
                    ["vue"] = override_icon_color_name("", "#41B883", "Vue"),
                    ["woff"] = override_icon_color_name("", "#886CC4", "WebOpenFontFormat"),
                    ["woff2"] = override_icon_color_name("", "#886CC4", "WebOpenFontFormat"),
                    ["xml"] = override_icon_color_name("", "#E44B4D", "Xml"),
                    ["yaml"] = override_icon_color_name("", "#FFA124", "Yaml"),
                    ["yml"] = override_icon_color_name("", "#FFA124", "Yml"),

                    ["spec.js"] = override_icon_color_name("󰙨", "#F0DB4F", "SpecJs"),
                    ["spec.jsx"] = override_icon_color_name("󰙨", "#0081A3", "JavaScriptReactSpec"),
                    ["spec.ts"] = override_icon_color_name("󰙨", "#007ACC", "SpecTs"),
                    ["spec.tsx"] = override_icon_color_name("󰙨", "#0081A3", "TypeScriptReactSpec"),
                    ["stories.js"] = override_icon_color_name("󱩵", "#F0DB4F", "StorybookJavaScript"),
                    ["stories.jsx"] = override_icon_color_name("󱩵", "#0081A3", "StorybookJsx"),
                    ["stories.mjs"] = override_icon_color_name("󱩵", "#FF4785", "StorybookMjs"),
                    ["stories.svelte"] = override_icon_color_name("󱩵", "#FF4785", "StorybookSvelte"),
                    ["stories.ts"] = override_icon_color_name("󱩵", "#007ACC", "StorybookTypeScript"),
                    ["stories.tsx"] = override_icon_color_name("󱩵", "#0081A3", "StorybookTsx"),
                    ["stories.vue"] = override_icon_color_name("󱩵", "#41B883", "StorybookVue"),
                    ["test.js"] = override_icon_color_name("", "#F0DB4F", "TestJs"),
                    ["test.jsx"] = override_icon_color_name("", "#0081A3", "JavaScriptReactTest"),
                    ["test.ts"] = override_icon_color_name("", "#007ACC", "TestTs"),
                    ["test.tsx"] = override_icon_color_name("", "#0081A3", "TypeScriptReactTest"),
                    [".clang-format"] = override_icon_color_name("", "#0D5D6C", "ClangFormat"),
                    ["_clang-format"] = override_icon_color_name("", "#0D5D6C", "ClangFormat"),
                    ["stylua.toml"] = override_icon_color_name("", "#1564C0", "Stylua"),
                    [".prettierrc"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    [".prettierrc.json"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    [".prettierrc.yml"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    [".prettierrc.yaml"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    [".prettierrc.json5"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    [".prettierrc.js"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    [".prettierrc.ts"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    ["prettier.config.js"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    ["prettier.config.ts"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    [".prettierrc.mjs"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    [".prettierrc.mts"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    ["prettier.config.mjs"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    ["prettier.config.mts"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    [".prettierrc.cjs"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    [".prettierrc.cts"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    ["prettier.config.cjs"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    ["prettier.config.cts"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    [".prettierrc.toml"] = override_icon_color_name("", "#F08B9C", "Prettier"),
                    ["application.properties"] = override_icon_color_name("", "#6DB33F", "SpringBootEnterPoint"),
                    ["application.yml"] = override_icon_color_name("", "#6DB33F", "SpringBootEnterPoint"),
                    [".vscode"] = override_icon_color_name("", "#0078D7", "VscodeProject"),
                    [".idea"] = override_icon_color_name("", "#B1428A", "IntelliJProject"),
                    [".git"] = override_icon_color_name("", "#F1502F", "GitConfig"),
                    [".gitignore"] = override_icon_color_name("", "#F1502F", "GitIgnore"),
                    [".mvn"] = override_icon_color_name("", "#FF6804", "MavenProject"),
                    ["mvnw"] = override_icon_color_name("", "#FF6804", "MavenProject"),
                    ["po.xml"] = override_icon_color_name("", "#FF6804", "MavenDependencies"),
                    ["node_modules"] = override_icon_color_name("", "#FF6804", "NodeModules"),
                    [".env"] = override_icon_color_name("", "#FBBC05", "Environment"),
                },
                default = true,
            })
        end,
    },
}
