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
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        cmd = "CompetiTest",
        config = function()
            require("competitest").setup({
                compile_command = {
                    cpp = {
                        exec = "g++",
                        args = {
                            "-std=c++20",
                            "-O2",
                            "-Wall",
                            "-Wextra",
                            "-DLOCAL", --#ifdef LOCAL guards for debug-only code
                            "$(FNAME)",
                            "-o",
                            "$(FNOEXT)",
                        },
                    },
                },
                run_command = {
                    cpp = { exec = "./$(FNOEXT)" },
                },
                maximum_time = 1000, --1 second time limit
                view_output_diff = true, --highlight differences from expected output
                received_problems_path = "$(HOME)/competitive/$(JUDGE)/$(CONTEST)/$(PROBLEM).cpp",
                received_contests_directory = "$(HOME)/competitive/$(JUDGE)/$(CONTEST)",
                open_received_problems = true,
                open_received_contests = true,
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
