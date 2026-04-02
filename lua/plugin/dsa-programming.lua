--C++ in LeetCode, Codeforces, USACO, AtCoder, etc
return {
    --LeetCode
    {
        "kawre/leetcode.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        cmd = "Leet",
        opts = {
            lang = "cpp",
            injector = {
                ["cpp"] = {
                    before = {
                        "#include <bits/stdc++.h>",
                        "using namespace std;",
                        "using ll = long long;",
                        "auto _ = [](){return ios::sync_with_stdio(0),cin.tie(0),0;}();",
                    },
                },
            },
            hooks = {
                ["enter"] = {
                    function() vim.cmd("normal! gg=G") end, --auto format codes
                },
            },
        },
        keys = {
            { "<F3>", "<cmd>Leet<CR>", mode = "n", desc = "LeetCode home" },
            { "<S-F3>", "<cmd>Leet run<CR>", mode = "n", desc = "LeetCode test" },
            { "<C-F3>", "<cmd>Leet submit<CR>", mode = "n", desc = "LeetCode submit" },
            { "<A-F3>", "<cmd>Leet exit<CR>", mode = "n", desc = "LeetCode close" },
            { "<leader>lp", "<cmd>Leet list<CR>", mode = "n", desc = "leetcode problem list" },
            { "<leader>lc", "<cmd>Leet console<CR>", mode = "n", desc = "leetcode console" },
            { "<leader>li", "<cmd>Leet info<CR>", mode = "n", desc = "leetcode problem info" },
            { "<leader>lt", "<cmd>Leet tabs<CR>", mode = "n", desc = "leetcode open tabs" },
            { "<leader>lL", "<cmd>Leet lang<CR>", mode = "n", desc = "leetcode change language" },
        },
    },
    --competive programming test runner
    --install competitive companion extension in a browser to auto-fetch problems/contests
    {
        "xeluxee/competitest.nvim",
        dependencies = "MunifTanjim/nui.nvim",
        config = function()
            require("competitest").setup({
                local_config_file_name = ".competitest.lua",
                floating_border = "rounded",
                floating_border_highlight = "CmpBorder",
                picker_ui = {
                    width = 0.3,
                    height = 0.5,
                    mappings = {
                        focus_next = { "j", "<Tab>" },
                        focus_prev = { "k", "<S-Tab>" },
                        close = { "<Esc>", "q" },
                        submit = "<CR>",
                    },
                },
                editor_ui = {
                    popup_width = 0.3,
                    popup_height = 0.5,
                    show_nu = true, --show line numbers
                    show_rnu = true, --show relative line numbers
                    normal_mode_mappings = {
                        switch_window = { "<S-Tab>", "<S-CR>", "<C-s>" },
                        save_and_close = { "wq", "<C-CR>" },
                        cancel = "q",
                    },
                    insert_mode_mappings = {
                        switch_window = { "<S-Tab>", "<S-CR>", "<C-s>" },
                        save_and_close = { "<C-w>q", "<C-CR>" },
                        cancel = "<C-q>",
                    },
                },
                runner_ui = {
                    interface = "split",
                    selector_show_nu = false, --don't show line numbers in test cases selector
                    selector_show_rnu = false, --don't show relative line numbers in test cases selector
                    show_nu = true, --show line numbers in detailed window
                    show_rnu = true, --show relation line numbers in detailed window
                    mappings = {
                        run_again = "R",
                        run_all_again = "<C-r>",
                        kill = "K",
                        kill_all = "<C-k>",
                        view_input = { "i", "I" },
                        view_output = { "o", "O" },
                        view_stdout = { "s", "S" },
                        view_stderr = { "e", "E" },
                        toggle_diff = { "d", "D" },
                        close = "q",
                    },
                    viewer = {
                        width = 0.5,
                        height = 0.5,
                        show_nu = true,
                        show_rnu = true,
                        open_when_compilation_fails = true,
                    },
                },
                popup_ui = {
                    total_width = 0.9,
                    total_height = 0.9,
                    layout = {
                        {
                            1,
                            {
                                { 1, "so" }, --standard output at top-left corner
                                {
                                    1,
                                    {
                                        { 1, "tc" }, --testcases selector at left bottom-left corner
                                        { 1, "se" }, --standard error at right bottom-left corner
                                    },
                                },
                            },
                        },
                        {
                            1,
                            {
                                { 1, "eo" }, --expected output at top-right corner
                                { 1, "si" }, --standard input at bottom-right corner
                            },
                        },
                    },
                },
                split_ui = {
                    position = "right",
                    relative_to_editor = true, --open in a relative window to editor
                    total_width = 0.5,
                    vertical_layout = {
                        { 2, "so" }, --standard output at the first two rows
                        { 2, { { 1, "si" }, { 1, "eo" } } }, --standard input and expected output at the second two rows
                        { 1, { { 1, "tc" }, { 1, "se" } } }, --testcases and standard error at the last row
                    },
                    total_height = 0.5,
                    horizontal_layout = {
                        { 3, "so" }, --standard output at the first three columns
                        { 3, { { 1, "si" }, { 1, "eo" } } }, --standard input and expected output at the second three columns
                        { 1, { { 1, "ts" }, { 1, "se" } } }, --testcases and standard error at the last column
                    },
                },
                save_current_file = true,
                save_all_files = false,
                compile_directory = ".", --compile in the current directory
                compile_command = {
                    c = { exec = "gcc", args = { "-Wall", "-O2", "$(FNAME)", "-o", "$(FNOEXT)" } },
                    cpp = { exec = "g++", args = { "--std=c++20", "-O2", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
                    rust = { exec = "rustc", args = { "$(FNAME)" } },
                    java = { exec = "javac", args = { "$(FNAME)" } },
                },
                running_directory = ".", --run in the current directory
                run_command = {
                    c = { exec = "./$(FNOEXT)" },
                    cpp = { exec = "./$(FNOEXT)" },
                    rust = { exec = "./$(FNOEXT)" },
                    python = { exec = "python", args = { "$(FNAME)" } },
                    java = { exec = "java", args = { "$(FNOEXT)" } },
                },
                multiple_testing = 1, --only run one test case at the same time
                maximum_time = 5000, --every program that executed over 5 seconds will be killed
                output_compare_method = "squish", --whitespaces can different
                view_output_diff = true,
                testcases_directory = "./testcases",
                testcases_use_single_file = false, --store every test case in separated files
                testcases_auto_detect_storage = true,
                testcases_single_file_format = "$(FNOEXT)_all.testcases",
                testcases_input_file_format = "$(FNOEXT)_i_$(TCNUM).txt",
                testcases_output_file_format = "$(FNOEXT)_o_$(TCNUM).txt",
                companion_port = 27121, --default port
                receive_print_message = true, --shoe messages to users
                start_receiving_persistently_on_setup = false,
                template_file = { --template files
                    c = vim.fn.expand("~") .. "/competitive/templates/template.c",
                    cpp = vim.fn.expand("~") .. "/competitive/templates/template.cpp",
                    java = vim.fn.expand("~") .. "/competitive/templates/template.java",
                    py = vim.fn.expand("~") .. "/competitive/templates/template.py",
                },
                evaluate_template_modifiers = true, --convert modifiers to actual value
                date_format = "%a %b/%d/%y %I:%M:%S %p", --e.g. Thu Jan/01/26 01:12:59 pm
                received_files_extension = "cpp", --use C++ to solve problems
                received_problems_path = function(task, file_extension)
                    local hypen = string.find(task.group, " - ")
                    local judge, contest
                    if not hypen then
                        judge = task.group
                        contest = "single_problem"
                    else
                        judge = string.sub(task.group, 1, hypen - 1)
                        contest = string.sub(task.group, hypen + 3)
                    end

                    --replace characters that Microsoft Windows doesn't allow
                    contest = contest:gsub("[<>:\"/\\|?*]", "_"):gsub("%s+", " "):gsub(",%s*", ", ")

                    local dir = string.format("%s/competitive/%s/%s", vim.fn.expand("~"), judge, contest)
                    local path = string.format("%s/%s.%s", dir, task.name, file_extension)

                    --create the directory if it doesn't exist
                    if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, "p") end

                    return path
                end,
                received_problems_prompt_path = false, --don't show problem stored path confirmation
                received_contests_directory = "~/competitive/",
                received_contests_problems_path = function(task, file_extension)
                    local hypen = string.find(task.group, " - ")
                    local judge, contest
                    if not hypen then
                        judge = task.group
                        contest = "single_problem"
                    else
                        judge = string.sub(task.group, 1, hypen - 1)
                        contest = string.sub(task.group, hypen + 3)
                    end

                    contest = contest:gsub("[<>:\"/\\|?*]", "_"):gsub("%s+", " ")

                    local dir = string.format("%s/competitive/%s/%s", vim.fn.expand("~"), judge, contest)
                    local path = string.format("%s/%s.%s", dir, task.name, file_extension)

                    if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, "p") end

                    return path
                end,
                received_contests_prompt_directory = false, --don't show contest stored path confirmation
                received_contests_prompt_extension = false, --don't show contest extension confirmation
                open_received_problems = true,
                open_received_contests = true,
                replace_received_testcases = true, --replace received test cases with existing ones
            })
        end,
        keys = {
            --test cases
            { "<leader>ca", "<cmd>CompetiTest add_testcase<CR>", mode = "n", desc = "add test case" },
            { "<leader>ce", "<cmd>CompetiTest edit_testcase<CR>", mode = "n", desc = "edit test case" },
            { "<leader>cd", "<cmd>CompetiTest delete_testcase<CR>", mode = "n", desc = "delete test case" },
            --run
            { "<leader>cr", "<cmd>CompetiTest run<CR>", mode = "n", desc = "compile, run and test" },
            { "<leader>cR", "<cmd>CompetiTest run_no_compile<CR>", mode = "n", desc = "run without recompile" },
            { "<leader>cs", "<cmd>CompetiTest show_ui<CR>", mode = "n", desc = "show test UI" },
            --receive problems/contests
            { "<leader>cp", "<cmd>CompetiTest receive problem<CR>", mode = "n", desc = "receive problem" },
            { "<leader>cc", "<cmd>CompetiTest receive contest<CR>", mode = "n", desc = "receive contest" },
        },
    },
    --performance analyzer
    {
        "t-troebst/perfanno.nvim",
        cmd = {
            "PerfAnnotate",
            "PerfAnnotateFunction",
            "PerfAnnotateSelection",
            "PerfPickEvent",
            "PerfCycleFormat",
            "PerfToggleAnnotations",
            "PerfHottestLines",
            "PerfHottestSymbols",
            "PerfHottestCallersFunction",
        },
        config = function()
            local util = require("perfanno.util")
            require("perfanno").setup({
                line_highlights = util.make_bg_highlights("#0a001f", "#00fff7", 10),
                vt_highlight = { fg = "#ff62e5" },
            })
        end,
        keys = {
            { "<leader>pf", "<cmd>PerfAnnotate<CR>", mode = "n", desc = "perf: annotate file" },
            { "<leader>pF", "<cmd>PerfAnnotateFunction<CR>", mode = "n", desc = "perf: annotate function" },
            { "<leader>ps", "<cmd>PerfAnnotateSelection<CR>", mode = "v", desc = "perf: annotate selection" },
            { "<leader>pl", "<cmd>PerfHottestLines<CR>", mode = "n", desc = "perf: hottest lines" },
            { "<leader>pS", "<cmd>PerfHottestSymbols<CR>", mode = "n", desc = "perf: hottest symbols" },
            { "<leader>pc", "<cmd>PerfHottestCallersFunction<CR>", mode = "n", desc = "perf: hottest callers" },
            { "<leader>pt", "<cmd>PerfToggleAnnotations<CR>", mode = "n", desc = "perf: toggle annotations" },
            { "<leader>pe", "<cmd>PerfPickEvent<CR>", mode = "n", desc = "perf: pick event" },
        },
    },
}
