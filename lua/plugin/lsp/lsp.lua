return {
    -- === LSP server installer ===
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        event = "VeryLazy",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "",
                        package_pending = "󱑤",
                        package_uninstalled = "",
                    },
                },
                --automatically install via Mason
                ensure_installed = {
                    --LSP servers
                    --programming languages
                    "clangd", --C/C++
                    "jdtls", --Java
                    "pyright", --Python
                    "lua_ls", --Lua
                    --web development
                    "html", --HTML
                    "cssls", --CSS/SCSS/SASS/LESS
                    "tailwindcss", --Tailwind CSS
                    "emmet_ls", --Emmet snippets
                    "ts_ls", --JavaScript/TypeScript
                    "vtsls", --enhanced TypeScript for Vue
                    "volar", --Vue
                    --configuration
                    "jsonls", --JSON
                    "yamlls", --YAML
                    "lemminx", --XML
                    "taplo", --TOML
                    "dockerls", --Dockerfile
                    "docker_compose_language_service", --docker-compose.yml
                    --documentation
                    "marksman", --Markdown
                    "texlab", --LaTeX
                    --bash
                    "bashls", --Bash/Shell scripts
                    "vimls", --Vimscript

                    --formatters
                    "clang-format", --C/C++/Java
                    "prettier", --Web + Markdown
                    "sql-formatter", --SQL
                    "stylua", --Lua
                    "black", --Python
                    "isort", --Python import sorting
                    "shfmt", --Shell scripts
                    "latexindent", --LaTeX

                    --lintings
                    "eslint", --JavaScript/TypeScript linting

                    --DAP adapters (debuggers)
                    "codelldb", --C/C++
                    "java-debug-adapter", --Java
                    "java-test", --Java test (JUnit)
                    "js-debug-adapter", --JavaScript/TypeScript/React/Vue (Google Chrome DevTools)
                },
            })
        end,
    },
    -- === mason - lspconfig bridge ===
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = {
            "neovim/nvim-lspconfig", --provide default configs for servers
        },
        config = function()
            require("mason-lspconfig").setup({
                --auto-enable servers
                automatic_enable = true,
                --override default config
                handlers = {
                    --Lombok support for Java
                    ["jdtls"] = function()
                        local lombok_jar = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"

                        if vim.fn.filereadable(lombok_jar) == 0 then
                            vim.notify(
                                "Lombok jar not found at: " .. lombok_jar .. "\nRun :MasonInstall jdtls to reinstall.",
                                vim.log.levels.WARN
                            )
                        end

                        vim.lsp.config("jdtls", {
                            cmd = {
                                "jdtls",
                                "--jvm-arg=-javaagent:" .. lombok_jar,
                                "--jvm-arg=-Xbootclasspath/a:" .. lombok_jar,
                            },
                            settings = {
                                java = {
                                    --Maven integration
                                    import = {
                                        maven = { enabled = true },
                                        gradle = { enabled = true },
                                    },
                                    --code generation settings
                                    codeGeneration = {
                                        toString = {
                                            template = "${object.className}{${member.name()}=${member.value}, }}",
                                        },
                                        useBlocks = true,
                                    },
                                    --enable inlay hints for parameter names
                                    inlayHints = {
                                        parameterNames = { enabled = "all" },
                                    },
                                    --completion improvements
                                    completion = {
                                        favoriteStaticMembers = {
                                            "org.junit.Assert.*",
                                            "org.junit.Assume.*",
                                            "org.junit.jupiter.api.Assertions.*",
                                            "org.mockito.Mockito.*",
                                        },
                                        filteredTypes = {
                                            "com.sun.*",
                                            "io.micrometer.shaded.*",
                                            "java.awt.*",
                                            "jdk.*",
                                            "sun.*",
                                        },
                                    },
                                },
                            },
                        })
                        vim.lsp.enable("jdtls")
                    end,

                    --lemminx with Maven pom.xml schema
                    ["lemminx"] = function()
                        vim.lsp.config("lemminx", {
                            settings = {
                                xml = {
                                    completion = { autoCloseTags = true },
                                    validation = { enabled = true, schema = true },
                                    format = { enabled = true, splitAttributes = false },
                                    --associate pom.xml with the Maven 4.0 XSD
                                    fileAssociations = {
                                        {
                                            pattern = "**/pom.xml",
                                            systemId = "https://maven.apache.org/xsd/maven-4.0.0.xsd",
                                        },
                                        {
                                            pattern = "**/.mvn/extensions.xml",
                                            systemId = "https://maven.apache.org/xsd/core-extensions-1.1.0.xsd",
                                        },
                                        {
                                            pattern = "**/maven-wrapper.xml",
                                            systemId = "https://maven.apache.org/xsd/wrapper/maven-wrapper-1.0.0.xsd",
                                        },
                                    },
                                },
                            },
                        })
                        vim.lsp.enable("lemminx")
                    end,

                    --Vue/TypeScript integration
                    ["vtsls"] = function()
                        local vue_plugin_path = vim.fn.stdpath("data")
                            .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
                        vim.lsp.config("vtsls", {
                            filetypes = {
                                "javascript",
                                "javascriptreact",
                                "typescript",
                                "typescriptreact",
                                "vue",
                            },
                            settings = {
                                vtsls = {
                                    tsserver = {
                                        globalPlugins = {
                                            {
                                                name = "@vue/typescript-plugin",
                                                location = vue_plugin_path,
                                                languages = { "vue" },
                                                configNamespace = "typescript",
                                                enableForWorkspaceTypeScriptVersions = true,
                                            },
                                        },
                                    },
                                },
                                typescript = {
                                    inlayHints = {
                                        parameterNames = { enabled = "all" },
                                        variableTypes = { enabled = true },
                                        propertyDeclarationTypes = { enabled = true },
                                        functionLikeReturnTypes = { enabled = true },
                                    },
                                },
                            },
                        })
                        vim.lsp.enable("vtsls")
                    end,

                    -- fix JavaScript/TypeScript on save
                    ["eslint"] = function()
                        vim.lsp.config("eslint", {
                            settings = {
                                workingDirectories = { mode = "auto" },
                            },
                        })
                        vim.lsp.enable("eslint")
                        --auto-fix ESLint errors on save
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            pattern = {
                                "*.js",
                                "*.jsx",
                                "*.mjs",
                                "*.ts",
                                "*.tsx",
                                "*.mts",
                                "*.vue",
                            },
                            command = "EslintFixAll",
                        })
                    end,

                    -- Tailwind CSS
                    ["tailwindcss"] = function()
                        vim.lsp.config("tailwindcss", {
                            filetypes = {
                                "html",
                                "css",
                                "scss",
                                "sass",
                                "less",
                                "javascript",
                                "javascriptreact",
                                "typescript",
                                "typescriptreact",
                                "vue",
                            },
                            settings = {
                                tailwindCSS = {
                                    experimental = {
                                        classRegex = {
                                            --support clsx, cn(), tw``, etc.
                                            { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                                            { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                                            { "tw`([^`]*)`", "([^`]+)" },
                                            { "tw\\.\\w+`([^`]*)`", "([^`]+)" },
                                            { "tw\\(([^)]*)\\)\\s*`([^`]*)`", "([^`]+)" },
                                        },
                                    },
                                    validate = true,
                                },
                            },
                        })
                        vim.lsp.enable("tailwindcss")
                    end,

                    -- Python
                    ["pyright"] = function()
                        vim.lsp.config("pyright", {
                            settings = {
                                python = {
                                    analysis = {
                                        typeCheckingMode = "strict", --"off"|"basic"|"strict"
                                        autoSearchPaths = true,
                                        useLibraryCodeForTypes = true,
                                        diagnosticMode = "workspace",
                                        inlayHints = {
                                            variableTypes = true,
                                            functionReturnTypes = true,
                                        },
                                    },
                                },
                            },
                        })
                        vim.lsp.enable("pyright")
                    end,

                    -- Lua
                    ["lua_ls"] = function()
                        vim.lsp.config("lua_ls", {
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = "LuaJIT",
                                        path = vim.split(package.path, ";"),
                                    },
                                    workspace = {
                                        checkThirdParty = false,
                                        library = vim.api.nvim_get_runtime_file("", true),
                                    },
                                    diagnostics = { globals = { "vim", "require" } },
                                    hint = {
                                        enable = true,
                                        paramType = true,
                                        setType = true,
                                        arrayIndex = "Enable",
                                    },
                                    format = { enable = false }, --conform handles formatting
                                },
                            },
                        })
                        vim.lsp.enable("lua_ls")
                    end,

                    -- JSON
                    ["jsonls"] = function()
                        vim.lsp.config("jsonls", {
                            settings = {
                                json = {
                                    --auto schema detection
                                    schemas = require("schemastore").json.schemas(),
                                    validate = { enable = true },
                                },
                            },
                        })
                        vim.lsp.enable("jsonls")
                    end,

                    -- YAML
                    ["yamlls"] = function()
                        vim.lsp.config("yamlls", {
                            settings = {
                                yaml = {
                                    schemaStore = {
                                        enable = false,
                                        url = "",
                                    },
                                    schemas = require("schemastore").yaml.schemas(),
                                    validate = true,
                                    completion = true,
                                    hover = true,
                                },
                            },
                        })
                        vim.lsp.enable("yamlls")
                    end,
                },
            })

            --beautiful LSP diagnostic icons and highlights
            local icons = {
                Error = "",
                Warn = "",
                Hint = "󰌵",
                Info = "",
            }

            for type, icon in pairs(icons) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, {
                    text = icon,
                    texthl = hl,
                    numhl = hl,
                })
            end

            local hl = function(name, highlight) vim.api.nvim_set_hl(0, name, highlight) end
            hl("DiagnosticError", { fg = "#e06c75" })
            hl("DiagnosticWarn", { fg = "#e5c07b" })
            hl("DiagnosticHint", { fg = "#645394" })
            hl("DiagnosticInfo", { fg = "#028a0f" })

            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                virtual_text = false, --use tiny-inline-diagnostic
                severity_sort = true, --show highest severity first
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "󰌵",
                        [vim.diagnostic.severity.INFO] = "",
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                    },
                },
                float = {
                    border = "rounded",
                    source = true,
                    header = "",
                    prefix = "",
                    severity_sort = true, --display highest severity
                    scope = "cursor", --show diagnostics at cursor
                },
            })

            --buffer-local LSP keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    local key = function(mode, key, action, description)
                        vim.keymap.set(
                            mode,
                            key,
                            action,
                            { buffer = bufnr, silent = true, noremap = true, desc = "LSP: " .. description }
                        )
                    end

                    --navigation
                    key("n", "gd", vim.lsp.buf.definition, "go to definition")
                    key("n", "gD", vim.lsp.buf.declaration, "go to declaration")
                    key("n", "gi", vim.lsp.buf.implementation, "go to implementation")
                    key("n", "gr", vim.lsp.buf.references, "find references")
                    key("n", "K", vim.lsp.buf.hover, "show hover document")
                    key("n", "gK", vim.lsp.buf.signature_help, "show signature help")
                    key("i", "<C-s>", vim.lsp.buf.signature_help, "show signature help")

                    --actions
                    key("n", "<leader>lr", vim.lsp.buf.rename, "rename symbol")
                    key("n", "<leader>ll", "<cmd>LspInfo<CR>", "LSP server info")

                    --toggles
                    if client and client:supports_method("textDocument/inlayHint") then
                        key("n", "<leader>th", function()
                            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
                            vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
                        end, "toggle inlay hints")
                    end

                    --diagnostic navigation
                    local jump = vim.diagnostic.jump
                    local sev = vim.diagnostic.severity

                    key("n", "[d", function() jump({ count = -1, float = true }) end, "previous diagnostic")
                    key("n", "]d", function() jump({ count = 1, float = true }) end, "next diagnostic")
                    key(
                        "n",
                        "[e",
                        function() jump({ count = -1, float = true, severity = sev.ERROR }) end,
                        "previous error"
                    )
                    key("n", "]e", function() jump({ count = 1, float = true, severity = sev.ERROR }) end, "next error")
                    key(
                        "n",
                        "[w",
                        function() jump({ count = -1, float = true, severity = sev.WARN }) end,
                        "previous warning"
                    )
                    key(
                        "n",
                        "]w",
                        function() jump({ count = 1, float = true, severity = sev.WARN }) end,
                        "next warning"
                    )
                    key(
                        "n",
                        "[h",
                        function() jump({ count = -1, float = true, severity = sev.HINT }) end,
                        "previous hint"
                    )
                    key("n", "]h", function() jump({ count = 1, float = true, severity = sev.HINT }) end, "next hint")
                    key(
                        "n",
                        "[i",
                        function() jump({ count = -1, float = true, severity = sev.INFO }) end,
                        "previous info"
                    )
                    key("n", "]i", function() jump({ count = 1, float = true, severity = sev.INFO }) end, "next info")
                end,
            })
        end,
    },
    --handle auto schema detection
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
    },
    --DAPs
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
            --virtual DAP panel
            {
                "rcarriga/nvim-dap-ui",
                config = function()
                    local dap, dapui = require("dap"), require("dapui")
                    dapui.setup({
                        icons = { expanded = "▼", collapsed = "▶", current_frame = "▶" },
                        layouts = {
                            {
                                elements = {
                                    { id = "scopes", size = 0.40 },
                                    { id = "breakpoints", size = 0.20 },
                                    { id = "stacks", size = 0.20 },
                                    { id = "watches", size = 0.20 },
                                },
                                size = 50,
                                position = "left",
                            },
                            {
                                elements = {
                                    { id = "repl", size = 0.50 },
                                    { id = "console", size = 0.50 },
                                },
                                size = 12,
                                position = "bottom",
                            },
                        },
                    })
                    --auto open/close UI with session lifecycle
                    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
                    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
                    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
                end,
            },
            --show values inline
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {
                    enabled = true,
                    commented = false,
                    virt_text_pos = "eol",
                    highlight_changed_variables = true,
                    highlight_new_as_changed = true,
                    show_stop_reason = true,
                },
            },
        },

        config = function()
            local dap = require("dap")
            local data = vim.fn.stdpath("data")

            --C++
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = data .. "/mason/packages/codelldb/extension/adapter/codelldb",
                    args = { "--port", "${port}" },
                },
            }
            dap.configurations.cpp = {
                {
                    name = "debug current file (auto-compile)",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        --compile with debug symbols before launching
                        local src = vim.fn.expand("%:p")
                        local out = vim.fn.expand("%:p:r")
                        vim.fn.system(string.format("g++ -std=c++20 -g -O0 -DLOCAL \"%s\" -o \"%s\"", src, out))
                        return out
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                    runInTerminal = false,
                },
                {
                    name = "attach to running process",
                    type = "codelldb",
                    request = "attach",
                    pid = require("dap.utils").pick_process,
                    cwd = "${workspaceFolder}",
                },
            }
            dap.configurations.c = dap.configurations.cpp --C shows the same info like C++

            --Java
            dap.adapters.java = function(callback)
                callback({
                    type = "server",
                    host = "127.0.0.1",
                    port = 5005,
                })
            end
            dap.configurations.java = {
                {
                    name = "debug Java",
                    type = "java",
                    request = "attach",
                    hostName = "127.0.0.1",
                    port = 5005,
                },
            }

            --JavaScript/TypeScript/React/Vue
            local js_adapter_path = data .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "node",
                    args = { js_adapter_path, "${port}" },
                },
            }
            dap.adapters["pwa-chrome"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "node",
                    args = { js_adapter_path, "${port}" },
                },
            }

            local js_config = {
                {
                    name = "debug Node.js/TS (current file)",
                    type = "pwa-node",
                    request = "launch",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    runtimeExecutable = "node",
                    sourceMaps = true,
                    resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
                },
                {
                    name = "debug Node.js/TS (npm start)",
                    type = "pwa-node",
                    request = "launch",
                    runtimeExecutable = "npm",
                    runtimeArgs = { "run", "start" },
                    cwd = "${workspaceFolder}",
                    sourceMaps = true,
                    resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
                },
                --Attach to already-running Node process
                {
                    name = "attach to Node process",
                    type = "pwa-node",
                    request = "attach",
                    processId = require("dap.utils").pick_process,
                    cwd = "${workspaceFolder}",
                    sourceMaps = true,
                },
                --React/Vue in Google Chrome
                {
                    name = "debug React/Vue in Chrome",
                    type = "pwa-chrome",
                    request = "launch",
                    url = "http://localhost:5173",
                    webRoot = "${workspaceFolder}/src",
                    sourceMaps = true,
                    sourceMapPathOverrides = {
                        ["webpack:///src/*"] = "${webRoot}/*",
                        ["vite:///src/*"] = "${webRoot}/*",
                    },
                },
                --React
                {
                    name = "debug React in Chrome (localhost:3000)",
                    type = "pwa-chrome",
                    request = "launch",
                    url = "http://localhost:3000",
                    webRoot = "${workspaceFolder}/src",
                    sourceMaps = true,
                },
            }

            dap.configurations.javascript = js_config
            dap.configurations.typescript = js_config
            dap.configurations.javascriptreact = js_config
            dap.configurations.typescriptreact = js_config
            dap.configurations.vue = js_config

            --HTML/CSS
            dap.configurations.html = {
                {
                    name = "open HTML in Chrome with DevTools",
                    type = "pwa-chrome",
                    request = "launch",
                    file = "${file}",
                    webRoot = "${workspaceFolder}",
                    sourceMaps = true,
                },
            }
            dap.configurations.css = dap.configurations.html
            dap.configurations.scss = dap.configurations.html

            --virtual text highlights
            vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#ff4500" })
            vim.api.nvim_set_hl(0, "DapBreakpointCond", { fg = "#d5a623" })
            vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#00b3ff" })
            vim.api.nvim_set_hl(0, "DapStopped", { fg = "#ff62e5", bg = "#1c1c3d" })

            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointCond" })
            vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
            vim.fn.sign_define("DapStopped", { text = "󰙦", texthl = "DapStopped", linehl = "DapStopped" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })
        end,

        keys = {
            --execution
            {
                "<F9>",
                function() require("dap").continue() end,
                mode = "n",
                desc = "debug: start / continue",
            },
            { "<S-F9>", function() require("dap").terminate() end, mode = "n", desc = "debug: stop" },
            {
                "<C-F9>",
                function() require("dap").run_to_cursor() end,
                mode = "n",
                desc = "debug: run to cursor",
            },
            { "<F10>", function() require("dap").step_over() end, mode = "n", desc = "debug: step over" },
            { "<F11>", function() require("dap").step_into() end, mode = "n", desc = "debug: step into" },
            { "<S-F11>", function() require("dap").step_out() end, mode = "n", desc = "debug: step out" },

            --breakpoints
            {
                "<leader>db",
                function() require("dap").toggle_breakpoint() end,
                mode = "n",
                desc = "toggle breakpoint",
            },
            {
                "<leader>dB",
                function() require("dap").set_breakpoint(vim.fn.input("condition: ")) end,
                mode = "n",
                desc = "conditional breakpoint",
            },
            {
                "<leader>dl",
                function() require("dap").set_breakpoint(nil, nil, vim.fn.input("log msg: ")) end,
                mode = "n",
                desc = "log point",
            },
            {
                "<leader>dx",
                function() require("dap").clear_breakpoints() end,
                mode = "n",
                desc = "clear all breakpoints",
            },

            --UI
            {
                "<leader>du",
                function() require("dapui").toggle() end,
                mode = "n",
                desc = "toggle debug UI",
            },
            {
                "<leader>de",
                function() require("dapui").eval() end,
                mode = { "n", "v" },
                desc = "eval expression",
            },
            {
                "<leader>df",
                function() require("dapui").float_element() end,
                mode = "n",
                desc = "float debug element",
            },
            {
                "<leader>dr",
                function() require("dap").repl.open() end,
                mode = "n",
                desc = "open debug REPL",
            },

            --session
            {
                "<leader>dL",
                function() require("dap").run_last() end,
                mode = "n",
                desc = "re-run last session",
            },
            {
                "<leader>dp",
                function() require("dap").pause() end,
                mode = "n",
                desc = "pause execution",
            },
        },
    },
}
