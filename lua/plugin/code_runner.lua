return {
    {
        "rebelot/terminal.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<C-,>",
                function() require("terminal").toggle() end,
                mode = "n",
                desc = "toggle terminal",
            },
        },
        config = function()
            require("terminal").setup({
                default_cwd = vim.fn.getcwd(),
                layout = {
                    open_cmd = "split", --open in horizontal split window
                    size = 12, --height
                },
                float_opts = {
                    border = "rounded",
                },
            })
        end,
    },
    "CRAG666/code_runner.nvim",
    event = "VeryLazy",
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<F5>", "<cmd>RunCode<cr>", mode = "n", desc = "run code" },
        { "<S-F5>", "<cmd>RunFile<cr>", mode = "n", desc = "run file" },
        { "<C-F5>", "<cmd>RunProject<cr>", mode = "n", desc = "run project" },
        { "<leader>rc", "<cmd>runclose<cr>", mode = "n", desc = "close terminal" },
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
    end,
}
