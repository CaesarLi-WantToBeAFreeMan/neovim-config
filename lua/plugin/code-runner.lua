local M = {}

local is_win = vim.fn.has("win32") == 1

--pause after execution
local pause = is_win and "; Write-Host ''; Read-Host 'press Enter to exit'"
    or "; echo; read -n1 -rp 'press any key to exit...'"

--run a shell command in snacks terminal
---@param cmd string
local function run(cmd)
    Snacks.terminal(cmd .. " " .. pause, {
        interactive = true,
        win = {
            position = "bottom",
            height = 0.4,
        },
    })
end

--search cwd for a file
---@param markers string[]
---@return string|nil
local function find_root(markers)
    local path = vim.fn.expand("%:p:h")
    local found = vim.fs.find(markers, { path = path, upward = true })[1]
    return found and vim.fn.fnamemodify(found, ":h") or nil
end

--cd to working directory then run
---@param dir string
---@param cmd string
local function cd_run(dir, cmd)
    if is_win then
        run(string.format("Set-Location \"%s\"; %s", dir, cmd))
    else
        run(string.format("cd %s && %s", vim.fn.shellescape(dir), cmd))
    end
end

--Shellescape a path cross-platform
---@param path string
---@return string
local function q(path) return is_win and ("\"" .. path .. "\"") or vim.fn.shellescape(path) end

-- === single file runner ===
local single = {}

function single.cpp()
    local src = vim.fn.expand("%:p")
    local dir = vim.fn.expand("%:p:h")
    local out = vim.fn.expand("%:p:r") .. (is_win and ".exe" or "")
    if is_win then
        run(
            string.format(
                "Set-Location \"%s\"; g++ -std=c++20 -O2 -Wall \"%s\" -o \"%s\"; cmd /c \"\"%s\"\"",
                dir,
                src,
                out,
                out
            )
        )
    else
        cd_run(dir, string.format("g++ -std=c++20 -O2 -Wall %s -o %s && ./%s", q(src), q(out), q(out)))
    end
end

function single.c()
    local src = vim.fn.expand("%:p")
    local dir = vim.fn.expand("%:p:h")
    local out = vim.fn.expand("%:p:r") .. (is_win and ".exe" or "")
    if is_win then
        run(
            string.format(
                "Set-Location \"%s\"; gcc -O2 -Wall -lm \"%s\" -o \"%s\"; cmd /c \"\"%s\"\"",
                dir,
                src,
                out,
                out
            )
        )
    else
        cd_run(dir, string.format("gcc -O2 -Wall -lm %s -o %s && ./%s", q(src), q(out), q(out)))
    end
end

function single.java()
    local file = vim.fn.expand("%:p")
    local out = vim.fn.expand("%:p:r") .. (is_win and ".exe" or "")
    if is_win then
        run(string.format("rustc \"%s\" -o \"%s\"; cmd /c \"\"%s\"\"", file, out, out))
    else
        run(string.format("rustc %s -o %s && %s", q(file), q(out), q(out)))
    end
end

function single.python()
    local file = vim.fn.expand("%:p")
    run(string.format("python %s", q(file)))
end

function single.lua()
    local file = vim.fn.expand("%:p")
    run(string.format("lua %s", q(file)))
end

function single.javascript()
    local file = vim.fn.expand("%:p")
    run(string.format("node %s", q(file)))
end

function single.typescript()
    local file = vim.fn.expand("%:p")
    run(string.format("npx ts-node %s", q(file)))
end

function single.rust()
    local file = vim.fn.expand("%:p")
    local out = vim.fn.expand("%:p:r") .. (is_win and ".exe" or "")
    run(string.format("rustc %s -o %s && %s", q(file), q(out), q(out)))
end

function single.go()
    local file = vim.fn.expand("%:p")
    run(string.format("go run %s", q(file)))
end

function single.sh()
    local file = vim.fn.expand("%:p")
    run(string.format("bash %s", q(file)))
end

function single.markdown()
    -- open in browser
    vim.cmd("RenderMarkdown toggle")
end

-- === project runner
local project = {}

--C++
--Cmake, Qt
function project.cmake()
    local root = find_root({ "CMakeLists.txt" })
    if not root then return false end

    local cmake_file = root .. "/CMakeLists.txt"
    local content = table.concat(vim.fn.readfile(cmake_file), "\n")
    local is_qt = content:match("[Ff]ind_package%s*%(%s*Qt")

    local build = root .. "/build"
    local configure_flags = "-DCMAKE_BUILD_TYPE=Release"
    if is_qt then
        local qt_prefix = is_win and "C:/Qt/6.7.0/msvc2019_64" --or your qt installed location
            or "/usr/lib/qt6"
        configure_flags = configure_flags .. string.format(" -DCMAKE_PREFIX_PATH=%s", q(qt_prefix))
    end

    cd_run(
        root,
        string.format(
            "cmake -S . -B %s %s && cmake --build %s --config Release && echo '✓ build done'",
            q(build),
            configure_flags,
            q(build)
        )
    )
    return true
end

--MFC
function project.mfc()
    if not is_win then
        vim.notify("MFC projects require Microsoft Windows + Microsoft Visual Studio", vim.log.levels.WARN)
        return false
    end
    local root = find_root({ "*.vcxproj", "*.sln" })
    if not root then return false end

    local sln = vim.fn.glob(root .. "/*.sln")
    if sln == "" then sln = vim.fn.glob(root .. "/*.vcxproj") end
    if sln == "" then return false end

    cd_run(root, string.format("MSBuild %s /p:Configuration=Debug /p:Platform=\"x64\" /m", q(sln)))
    return true
end

-- Java
---Maven project
function project.maven()
    local root = find_root({ "pom.xml" })
    if not root then return false end

    local pom = table.concat(vim.fn.readfile(root .. "/pom.xml"), "\n")
    local is_boot = pom:match("spring%-boot")

    if is_boot then
        cd_run(root, "mvn spring-boot:run")
    else
        cd_run(root, "mvn compile exec:java")
    end
    return true
end

---Gradle project
function project.gradle()
    local root = find_root({ "build.gradle", "build.gradle.kts" })
    if not root then return false end

    local build_file = vim.fn.glob(root .. "/build.gradle*")
    local content = table.concat(vim.fn.readfile(build_file), "\n")
    local is_boot = content:match("spring%-boot")
    local gradlew = is_win and "gradlew.bat" or "./gradlew"

    -- prefer wrapper if present
    if vim.fn.filereadable(root .. "/gradlew") == 1 or vim.fn.filereadable(root .. "/gradlew.bat") == 1 then
        if is_boot then
            cd_run(root, gradlew .. " bootRun")
        else
            cd_run(root, gradlew .. " run")
        end
    else
        if is_boot then
            cd_run(root, "gradle bootRun")
        else
            cd_run(root, "gradle run")
        end
    end
    return true
end

---Plain Java project
function project.java()
    local root = find_root({ "src" })
    if not root then return false end

    local out = root .. "/out"
    cd_run(
        root,
        string.format(
            "mkdir -p %s && find src -name '*.java' | xargs javac -d %s && java -cp %s Main",
            q(out),
            q(out),
            q(out)
        )
    )
    return true
end

--Python
--Python project
function project.python()
    local root = find_root({ "pyproject.toml", "setup.py", "manage.py", "main.py" })
    if not root then return false end

    if vim.fn.filereadable(root .. "/manage.py") == 1 then
        --Django
        cd_run(root, "python manage.py runserver")
        return true
    end

    local entry = vim.fn.filereadable(root .. "/main.py") == 1 and "main.py"
        or vim.fn.filereadable(root .. "/app.py") == 1 and "app.py"
        or nil
    if entry then
        cd_run(root, string.format("python %s", entry))
        return true
    end

    return false
end

--Web
--Vite project
function project.vite()
    local root = find_root({ "vite.config.ts", "vite.config.js", "vite.config.mjs" })
    if not root then return false end
    local npm = vim.fn.filereadable(root .. "/yarn.lock") == 1 and "yarn"
        or vim.fn.filereadable(root .. "/pnpm-lock.yaml") == 1 and "pnpm"
        or "npm"
    cd_run(root, npm .. " run dev")
    return true
end

--Generic Node
function project.node()
    local root = find_root({ "package.json" })
    if not root then return false end

    local pkg = vim.fn.json_decode(table.concat(vim.fn.readfile(root .. "/package.json"), "\n"))
    local scripts = pkg and pkg.scripts or {}

    local preferred = { "dev", "start", "serve", "preview" }
    local npm = vim.fn.filereadable(root .. "/yarn.lock") == 1 and "yarn"
        or vim.fn.filereadable(root .. "/pnpm-lock.yaml") == 1 and "pnpm"
        or "npm run"

    for _, s in ipairs(preferred) do
        if scripts[s] then
            cd_run(root, string.format("%s %s", npm, s))
            return true
        end
    end

    --node index.js / main.js
    local entry = vim.fn.filereadable(root .. "/index.js") == 1 and "index.js"
        or vim.fn.filereadable(root .. "/main.js") == 1 and "main.js"
        or nil
    if entry then
        cd_run(root, string.format("node %s", entry))
        return true
    end
    return false
end

--static web
function project.static_web()
    local root = find_root({ "index.html" })
    if not root then return false end
    local file = root .. "/index.html"
    local open = is_win and "start" or vim.fn.has("mac") == 1 and "open" or "xdg-open"
    run(string.format("%s %s", open, q(file)))
    return true
end

--Rust cargo project
function project.cargo()
    local root = find_root({ "Cargo.toml" })
    if not root then return false end
    cd_run(root, "cargo run")
    return true
end

--Go module project
function project.go()
    local root = find_root({ "go.mod" })
    if not root then return false end
    cd_run(root, "go run .")
    return true
end

--dispatcher
--priority-ordered project detectors
local project_chain = {
    --C++
    project.cmake, --Cmake, QT projects
    project.mfc, --Microsoft Windows MFC projects
    --Java
    project.maven, --Maven projects
    project.gradle, --Gradle projects
    project.java, --Plain Java projects
    --Python
    project.python, --pyprojects
    --Node / Web
    project.vite, --Vite projects
    project.node, --node projects
    project.static_web, --static web projects
    --other
    project.cargo, --Rust Cargo projects
    project.go, --Go projects
}

--single file runner
local single_map = {
    c = single.c,
    cpp = single.cpp,
    java = single.java,
    python = single.python,
    lua = single.lua,
    javascript = single.javascript,
    typescript = single.typescript,
    rust = single.rust,
    go = single.go,
    sh = single.sh,
    bash = single.sh,
    markdown = single.markdown,
}

function M.run()
    --run a project project first
    for _, detector in ipairs(project_chain) do
        if detector() then return end
    end

    --run a single file later
    local ft = vim.bo.filetype
    local runner = single_map[ft]
    if runner then
        runner()
    else
        vim.notify(string.format("no runner for filetype '%s'", ft), vim.log.levels.WARN)
    end
end

function M.run_file()
    --always run current file
    local ft = vim.bo.filetype
    local runner = single_map[ft]
    if runner then
        runner()
    else
        vim.notify(string.format("no single-file runner for filetype '%s'", ft), vim.log.levels.WARN)
    end
end

return {
    dir = vim.fn.stdpath("config"), --points to your config dir
    name = "code-runner", --unique name so lazy won't conflict
    lazy = false,
    priority = 500,
    keys = {
        { "<F5>", function() M.run() end, mode = "n", desc = "smart code runner" },
        { "<S-F5>", function() M.run_file() end, mode = "n", desc = "run current file only" },
    },
    config = function()
        _G.RunCode = M.run
        _G.RunCodeFile = M.run_file
    end,
}
