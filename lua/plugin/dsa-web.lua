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
                    imports = function()
                        return { "#include <bits/stdc++.h>", "using namespace std;" }
                    end,
                    after = "int main() {}",
                },
            }
        },
        keys = {
            { "<F3>",   "<cmd>Leet<CR>",        desc = "open leetcode",      mode = "n" },
            { "<S-F3>", "<cmd>Leet run<CR>",    desc = "test the problem",   mode = "n" },
            { "<C-F3>", "<cmd>Leet submit<CR>", desc = "submit the problem", mode = "n" },
            { "<A-F3>", "<cmd>Leet exit<CR>",   desc = "close leetcode",     mode = "n" },
        }
    },
    --codeforces
}
