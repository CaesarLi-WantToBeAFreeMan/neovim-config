--shorthand
local opt = vim.opt --Neovim options
local undo_dir = vim.fn.stdpath("data") .. "/undo" --path for persistent undo files

--create undo directory if it doesn't exist
if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(undo_dir, "p") --ensure undo directory exists
end

-- === encoding ===
opt.encoding = "utf-8" --internal text encoding
opt.fileencoding = "utf-8" --save files in UTF-8 encoding
opt.fileencodings = { "ucs-bom", "utf-8", "cp1252", "default" }
opt.fileformats = { "unix", "dos", "mac" } --support multiple line-ending formats

-- === backup & undo ===
opt.backup = false --disable backup files
opt.writebackup = false --disable backup before overwriting
opt.swapfile = false --disable swap files
opt.undofile = true --enable persistent undo
opt.undodir = undo_dir --store undo history in custom directory
opt.undolevels = 10000 --maximum number of undo levels

-- === clipboard ===
opt.clipboard = vim.fn.has("win32") == 1 and "unnamed" --use Windows system clipboard(unnamed)
    or "unnamedplus" --use Unix-like OS clipboard(unnamedplus)

-- ==== mouse ===
opt.mouse = "" --disable mouse for all modes

-- === command Line ===
opt.cmdheight = 1 --height of command line
opt.showcmd = false --hide command display
opt.showmode = false --hide current mode display
opt.wildmode = "longest:full,full" --command-line completion mode
opt.wildignorecase = true --ignore case in command line completion
opt.wildignore = { --files to ignore in completion
    "*.o",
    "*.obj",
    "*.a",
    "*.class",
    "*.jar",
    "*.pyc",
    "*.pyo",
    "__pycache__",
    "*.exe",
    "*.dll",
    "*.so",
    "node_modules",
    ".git",
    ".svn",
    "*.jpg",
    "*.jpeg",
    "*.png",
    "*.gif",
    "*.bmp",
    "*.webp",
    "*.zip",
    "*.tar",
    "*.gz",
    "*.rar",
}

-- === completion ===
opt.completeopt = { "menu", "menuone", "noselect" } --configure completion menu behavior
opt.pumblend = 12 --popup blend
opt.pumheight = 12 --limit popup menu height to 12 items
opt.shortmess:append("c") --don't show completion messages in cmdline

-- === timing ===
opt.updatetime = 210 --faster CursorHold events (ms)
opt.timeoutlen = 500 --mapped sequence wait time (ms)
opt.ttimeoutlen = 10 --key code sequence wait time (mds
opt.redrawtime = 1200 --max time for syntax highlighting per redraw (ms)

-- === behavior ===
opt.confirm = true --prompt confirmation for unsaved buffers
opt.autoread = true --auto-load files changed externally
opt.hidden = true --allow switching buffers without saving
opt.switchbuf = "usetab" --reuse existing tab when switching buffers
opt.startofline = false --keep column position when jumping lines
opt.virtualedit = "block" --allow cursor past end of line in block mode
opt.whichwrap = "b,s,<,>,[,]" --allow these keys to move across line breaks
opt.nrformats = "bin,hex" --allow <C-a>(increase)/<C-x>(decrease) on binary and hex numbers
opt.path:append("**") --search files recursively with :find

-- === search ===
opt.hlsearch = true --highlight search results
opt.incsearch = true --show matches while typing pattern
opt.ignorecase = true --ignore case in searches
opt.smartcase = true --case sensitive if search contains uppercase
opt.wrapscan = true --loops search back to top
--grepprg is the fastest search tool and which is better than the built-in older one
opt.grepprg = "rg --vimgrep --smart-case --follow" --use ripgrep for :grep
opt.grepformat = "%f:%l:%c:%m"

-- === indentation ===
opt.tabstop = 4 --set tab width to 4 spaces
opt.shiftwidth = 4 --set indent width to 4 spaces
opt.softtabstop = 4 --set spaces per tab in insert mode
opt.expandtab = true --convert tabs to spaces
opt.autoindent = true --copy indent from previous line
opt.smartindent = true --enable smarter auto-indentation
opt.shiftround = true --round indent to nearest shiftwidth
opt.copyindent = true --copy structure of existing indentation
opt.preserveindent = true --preserve indent structure

-- === wrapping ===
opt.wrap = true --enable line wrapping
opt.linebreak = true --wrap lines at word boundaries
opt.breakindent = true --preserve indent on wrapped lines
opt.wrapmargin = 3 --set margin before wrapping
opt.formatoptions = "jcrqlnt" --configure formatting
opt.synmaxcol = 120 --limit syntax highlight to 120 columns
opt.textwidth = 0 --disable automatic line breaking

-- === display ===
opt.number = true --show absolute line numbers
opt.relativenumber = true --show relative line numbers
opt.smoothscroll = true --enable smooth scroll
opt.scrolloff = 5 --keep 5 lines visible above/below cursor
opt.sidescrolloff = 5 --keep 5 columns visible left/right of cursor
opt.splitbelow = true --open horizontal splits below
opt.splitright = true --open vertical splits to the right
opt.splitkeep = "screen" --keep text in place when splitting
opt.termguicolors = true --enable true color support
opt.cursorline = true --highlight current line
opt.cursorcolumn = true --highlight current column
opt.signcolumn = "yes" --always show sign column
opt.colorcolumn = "120" --highlight column 120 as guide
opt.showmatch = true --briefly jump to matching bracket
opt.matchtime = 1 --how long to show matching bracket (s)

-- === status & tabline ===
opt.laststatus = 3 --use global statusline
opt.showtabline = 2 --show tabline only with multiple tabs
opt.ruler = false --disable default ruler

-- === folding ===
opt.foldenable = true --enable code folding
opt.foldlevel = 99 --open all folds by default
opt.foldlevelstart = 99 --all folds open when opening a file
opt.foldnestmax = 4 --maximum fold nesting depth
opt.foldcolumn = "1" --show fold column
opt.fillchars = { --custom fold and diff characters
    vert = "", --vertical split separator
    fold = "", --fold placeholder character
    foldopen = "", --icon for open folds
    foldclose = "", --icon for closed folds
    foldsep = "󰮾", --fold separator
    diff = "", --character used in diff view
    eob = " ", --remove tildes (~) at end of buffer
}

-- === window size ===
opt.winminheight = 1 --set minimum window height
opt.winminwidth = 1 --set minimum window width
opt.winheight = 12 --set preferred window height
opt.winwidth = 30 --set preferred window width
opt.equalalways = true --keep windows equal size after split/close

-- === spell checking ===
opt.spell = true --enable spell checking
opt.spelllang = { "en_us" } --use U.S. English dictionary
opt.spelloptions = "camel" --treat camelCase as separate words
opt.iskeyword:append("-") --treat hyphenated-words (e.g. CSS variables, class names) as one word

-- === performance ===
opt.lazyredraw = false --don't redraw during macros (false = safer with plugins)
opt.ttyfast = true --assume fast terminal connection

-- === session ===
opt.sessionoptions = { --save options in sessions
    "buffers", --open buffers
    "curdir", --current directory
    "tabpages", --tabs
    "winsize", --window sizes
    "help", --help window
    "globals", --global variables
    "skiprtp", --
    "folds", --folds
}

-- === terminal ===
-- if vim.fn.has("win32") == 1 then
--     vim.o.shell = "pwsh" --use PowerShell 7 instead of cmd, "powershell" is PowerShell 5
--     vim.o.shellcmdflag = "-NoLogo -NoProfile -Command"
--     vim.o.shellquote = ""
--     vim.o.shellxquote = ""
--     vim.o.shellpipe = "| Out-File -Encoding UTF8 %s"
--     vim.o.shellredir = "| Out-File -Encoding UTF8 %s"
-- end
if vim.fn.has("win32") == 1 then
    vim.o.shell = "cmd" --cmd is extremely faster than pwsh
    vim.o.shellcmdflag = "/c"
    vim.o.shellquote = ""
    vim.o.shellxquote = "\""
end
