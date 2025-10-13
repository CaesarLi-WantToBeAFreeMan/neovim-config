local opt = vim.opt
local has = vim.fn.has

--create undo directory if not exists
local undoDirectory = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undoDirectory) == 0 then
    vim.fn.mkdir(undoDirectory, "p")
end

--[[
    +-=====================-+
    | BASIC EDITOR BEHAVIOR |
    +-=====================-+
]]

--encoding and file formats
opt.encoding = "utf-8"                              --internal encoding
opt.fileencoding = "utf-8"                          --file write encoding
opt.fileformats = {"unix", "dos", "mac"}            --support LF, CRLF, CR

--backup, swap, undo
opt.backup = false                                  --disable backup files(file~)
opt.writebackup = false                             --disable write backup
opt.swapfile = false                                --disable swap files(.swp)
opt.undofile = true                                 --enable persistent undo
opt.undodir = undoDirectory                         --undo directory

--clipboard
--Microsoft Windows uses unnamed, and both Linux and Apple macOS use unnamedplus clipboard
opt.clipboard = (has("win32") == 1 or has("win64") == 1)
                and "unnamed"
                or "unnamedplus"

--mouse
opt.mouse = ""                                      --disable mouse

--command line
opt.cmdheight = 1                                   --command line height
opt.showcmd = false                                 --hide partial command
opt.showmode = false                                --hide mode text

--completion
opt.completeopt = {"menu", "menuone", "noselect"}   --show menu even for single match, do not auto-select
opt.pumheight = 12                                  --12 items in a popup menu

--timeout
opt.updatetime = 210                                --delay (ms) before swap file write
opt.timeoutlen = 300                                --timeout for mapped key sequences

--miscellaneous
opt.confirm = true                                  --confirm before quitting unsaved files
opt.autoread = true                                 --auto reload changed files
opt.autowrite = false                               --do not auto save when switching buffers

--[[
    +-=========-+
    | SEARCH    |
    +-=========-+
]]

opt.hlsearch = true                                 --highlight all matches
opt.incsearch = true                                --incremental search
opt.showmatch = true                                --jump to match briefly
opt.ignorecase = true                               --case-insensitive
opt.smartcase = true                                --override ignorecase if uppercase appears
opt.wrapscan = true                                 --loop search

--[[
    +-=====================-+
    | INDENTATION AND TABS  |
    +-=====================-+
]]

opt.tabstop = 4                                     --tab width
opt.shiftwidth = 4                                  --indent size
opt.softtabstop = 4                                 --insert tab width
opt.expandtab = true                                --use spaces
opt.smarttab = true                                 --smart tab insert
opt.autoindent = true                               --copy indent
opt.smartindent = true                              --auto-indent C-like
opt.cindent = false                                 --C-style indent, disable for using treesitter indent
opt.shiftround = true                               --round indent

--[[
    +-=============================-+
    | LINE WRAPPING AND FORMATTING  |
    +-=============================-+
]]

opt.wrap = true                                     --enable wrapping
opt.linebreak = true                                --wrap at word
opt.breakindent = true                              --preserve indent
opt.textwidth = 0                                   --no auto wrap limit
opt.wrapmargin = 3                                  --wrap margin
opt.formatoptions = "jcrqlnt"                       --j: remove comment leader when joining lines
                                                    --c: auto-wrap comments using textwidth
                                                    --r: auto-insert comment leader after <CR>
                                                    --o: auto-insert comment leader after o || O
                                                    --q: allow formatting comments with gq
                                                    --l: long lines not broken in insert mode
                                                    --n: recognize numbered lists when formatting
                                                    --t: auto-wrap text using textwidth
opt.lazyredraw = true                               --skip redraw in macros
opt.synmaxcol = 210                                 --210 columns to apply syntax highlighting


--[[
    +-=========================================-+
    | LINE NUMBERS, SCROLL, SPLITS, PERFORMANCE |
    +-=========================================-+
]]

opt.number = true                                   --show line numbers
opt.relativenumber = true                           --show relative line numbers
opt.scrolloff = 3                                   --keep 3 lines visible above/below
opt.sidescrolloff = 3                               --keep 3 lines visible on sides
opt.splitbelow = true                               --split horizontal windows below
opt.splitright = true                               --split vertical windows to right
opt.hidden = true                                   --allow unsaved buffer switching
opt.updatetime = 210                                --delay before CursorHold event in ms
opt.timeoutlen = 300                                --mapping timeout in ms

--[[
    +-=============-+
    | APPEARANCE    |
    +-=============-+
]]

opt.background = "dark"                             --dark mode
opt.termguicolors = true                            --enable 24-bit RGB colors in terminal
opt.cursorline = true                               --highlight line
opt.cursorcolumn = true                             --highlight column
opt.signcolumn = "yes"                              --always show sign column
opt.colorcolumn = "90"                              --ruler at column 90

--status line and tab line
opt.laststatus = 3                                  --global statusline(0 = never, 1 = only if 2+ windows, 2 = always, 3 = global)
opt.showtabline = 1                                 --show tabline(0 = never, 1 = only if 2+ tabs, 2 = always)

--conceal
opt.conceallevel = 0                                --show all text
opt.concealcursor = ""                              --no conceal on cursor

--fill characters
opt.fillchars = {
    fold = "",                                     --character to show for folded lines
    foldopen = "",                                 --character for open folds
    foldclose = "",                                --character for closed folds
    foldsep = "",                                  --character for fold column separator
    diff = "",                                     --character for deleted lines in diff mode
    eob = " ",                                      --character for empty lines at end of buffer
}

--list characters
opt.list = true                                     --show invisible characters
opt.listchars = {
    tab = "→ ",                                     --tab character
    trail = "▪",                                    --trailing space character
    nbsp = "␣",                                     --non-breaking spaces character
    extends = "▸",                                  --character when line extends beyond right
    precedes = "◂",                                 --character when line extends beyond left
}

--[[
    +-=========-+
    | FOLDING   |
    +-=========-+
]]

opt.foldenable = true                               --starts with folds close
opt.foldlevel = 3                                   --open top 3 levels
opt.foldnestmax = 12                                --maximum fold depth
opt.foldminlines = 1                                --minimum lines per fold
opt.foldcolumn = "1"                                --fold column width

--[[
    +-=============-+
    | WINDOW SIZE   |
    +-=============-+
]]

opt.winminheight = 1                                --minimum window height
opt.winminwidth = 1                                 --minimum window width
opt.winheight = 12                                  --active window height
opt.winwidth = 30                                   --active window width

--[[
    +-=================-+
    | SPELL CHECKING    |
    +-=================-+
]]

opt.spell = true                                    --enable spellcheck
opt.spelllang = {"en_us"}                           --spell languages

--[[
    +-=====================-+
    | SESSION MANAGEMENT    |
    +-=====================-+
]]

opt.sessionoptions = {
    "buffers",                                      --save all buffers
    "curdir",                                       --save current directory
    "tabpages",                                     --save all tab pages
    "winsize",                                      --save window sizes
    "globals",                                      --save global variables
    "skiprtp",                                      --do not save runtime path
}
