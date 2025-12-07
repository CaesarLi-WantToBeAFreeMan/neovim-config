return {
    --leetcode
    {
        "kawre/leetcode.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Leet",
        opts = {
            injector = {
                ["cpp"] = {
                    imports = function() return { "#include <bits/stdc++.h>", "using namespace std;" } end,
                    after = "int main() {}",
                },
            },
        },
        keys = {
            { "<F3>", "<cmd>Leet<CR>", desc = "open leetcode", mode = "n" },
            { "<S-F3>", "<cmd>Leet run<CR>", desc = "test the problem", mode = "n" },
            { "<C-F3>", "<cmd>Leet submit<CR>", desc = "submit the problem", mode = "n" },
            { "<A-F3>", "<cmd>Leet exit<CR>", desc = "close leetcode", mode = "n" },
        },
    },
    --codeforces
    --competive programming healer
    {
        "xeluxee/competitest.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        cmd = "CompetiTest",
        keys = {
            { "<leader>ca", "<cmd>CompetiTest add_testcase<CR>", desc = "add a test case", mode = "n" },
            { "<leader>ce0", "<cmd>CompetiTest edit_testcase 0<CR>", desc = "change test case 0 data", mode = "n" },
            { "<leader>ce1", "<cmd>CompetiTest edit_testcase 1<CR>", desc = "change test case 1 data", mode = "n" },
            { "<leader>ce2", "<cmd>CompetiTest edit_testcase 2<CR>", desc = "change test case 2 data", mode = "n" },
            { "<leader>ce3", "<cmd>CompetiTest edit_testcase 3<CR>", desc = "change test case 3 data", mode = "n" },
            { "<leader>ce4", "<cmd>CompetiTest edit_testcase 4<CR>", desc = "change test case 4 data", mode = "n" },
            { "<leader>ce5", "<cmd>CompetiTest edit_testcase 5<CR>", desc = "change test case 5 data", mode = "n" },
            { "<leader>ce6", "<cmd>CompetiTest edit_testcase 6<CR>", desc = "change test case 6 data", mode = "n" },
            { "<leader>ce7", "<cmd>CompetiTest edit_testcase 7<CR>", desc = "change test case 7 data", mode = "n" },
            { "<leader>ce8", "<cmd>CompetiTest edit_testcase 8<CR>", desc = "change test case 8 data", mode = "n" },
            { "<leader>ce9", "<cmd>CompetiTest edit_testcase 9<CR>", desc = "change test case 9 data", mode = "n" },
            { "<leader>cd0", "<cmd>CompetiTest delete_testcase 0<CR>", desc = "delete test case 0", mode = "n" },
            { "<leader>cd1", "<cmd>CompetiTest delete_testcase 1<CR>", desc = "delete test case 1", mode = "n" },
            { "<leader>cd2", "<cmd>CompetiTest delete_testcase 2<CR>", desc = "delete test case 2", mode = "n" },
            { "<leader>cd3", "<cmd>CompetiTest delete_testcase 3<CR>", desc = "delete test case 3", mode = "n" },
            { "<leader>cd4", "<cmd>CompetiTest delete_testcase 4<CR>", desc = "delete test case 4", mode = "n" },
            { "<leader>cd5", "<cmd>CompetiTest delete_testcase 5<CR>", desc = "delete test case 5", mode = "n" },
            { "<leader>cd6", "<cmd>CompetiTest delete_testcase 6<CR>", desc = "delete test case 6", mode = "n" },
            { "<leader>cd7", "<cmd>CompetiTest delete_testcase 7<CR>", desc = "delete test case 7", mode = "n" },
            { "<leader>cd8", "<cmd>CompetiTest delete_testcase 8<CR>", desc = "delete test case 8", mode = "n" },
            { "<leader>cd9", "<cmd>CompetiTest delete_testcase 9<CR>", desc = "delete test case 9", mode = "n" },
            { "<leader>cr", "<cmd>CompetiTest run<CR>", desc = "compile, run and test code", mode = "n" },
            { "<leader>cR", "<cmd>CompetiTest run_no_compile 9<CR>", desc = "run and test last one code", mode = "n" },
            { "<leader>cs", "<cmd>CompetiTest show_ui<CR>", desc = "show UI", mode = "n" },
        },
        config = function()
            require("competitest").setup({
                compile_command = {
                    cpp = {
                        exec = "g++",
                        args = { "-std=c++17", "-Wall", "-O2", "$(FNAME)", "-o", "$(FNOEXT)" },
                    },
                },
                maximum_time = 1000, --set time limit to 1 second
                view_output_diff = true, --show differences between outputs
            })
        end,
    },
}
