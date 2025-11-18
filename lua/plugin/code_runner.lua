return {
    "CRAG666/code_runner.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local is_windows = vim.fn.has("win32") == 1
        local function c_like_command(compiler, extra_flags)
            return function()
                local file, file_dir, output = vim.fn.expand("%:p"), vim.fn.expand("%:p:h"), vim.fn.expand("%:p:r")
                if is_windows then output = output .. ".exe" end
                local cd = "cd " .. (is_windows and "\"" .. file_dir .. "\"" or vim.fn.shellescape(file_dir)) .. " && "

                local cmd = table.concat({
                    cd,
                    compiler,
                    extra_flags or "",
                    vim.fn.shellescape(file),
                    "-o",
                    vim.fn.shellescape(output),
                    "&&",
                    (is_windows and "" or "./") .. vim.fn.shellescape(output),
                }, " ")

                return cmd
            end
        end

        require("code_runner").setup({
            mode = "term", --use Neovim's built-in terminal
            focus = true, --focus on the terminal
            startinsert = true, --tart in insert mode

            --single file
            filetype = {
                c = c_like_command("gcc", "-O2 -Wall -lm"),
                cpp = c_like_command("g++", "-std=c++20 -O2 -Wall"),
                java = {
                    "cd $dir &&",
                    "javac $fileName &&",
                    "java $fileNameWithoutExt",
                },
                python = "python3 $fileName",
            },

            --[[
            project = {
                ["pom.xml"] = {
                    name = "Spring Boot",
                    command = "cd $dir && mvn -q spring-boot:run",
                },
                ["package.json"] = {
                    name = "React or Vue",
                    command = "npm run dev || npm start",
                },
                ["CMakeLists.txt"] = {
                    name = "CMake",
                    command = "cmake -S . -B build && cmake --build build && ./build/*",
                },
            },
            filetype_path = vim.fn.stdpath("data") .. "/code_runner/filetypes.json", -- not needed usually
            project_path = vim.fn.stdpath("data") .. "/code_runner/projects.json",
            ]]
        })
        local opts = { noremap = true, silent = true }

        vim.keymap.set("n", "<F5>", "<cmd>RunCode<CR>", vim.tbl_extend("force", opts, { desc = "run code" }))
        vim.keymap.set("n", "<S-F5>", "<cmd>RunFile<CR>", vim.tbl_extend("force", opts, { desc = "run file" }))
        vim.keymap.set("n", "<C-F5>", "<cmd>RunProject<CR>", vim.tbl_extend("force", opts, { desc = "run project" }))
        vim.keymap.set(
            "n",
            "<leader>rc",
            "<cmd>RunClose<CR>",
            vim.tbl_extend("force", opts, { desc = "Close runner terminal" })
        )
    end,
}
