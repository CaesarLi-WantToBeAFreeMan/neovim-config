--shorthand access
local opt = vim.opt      --control editor options
local has = vim.fn.has   --check if a feature exists

--setup persistent undo directory
local undoDirectory = vim.fn.stdpath "data" .. "/undo"    --path for undo history files
if vim.fn.isdirectory(undoDirectory) == 0 then            --if the directory doesn't exist
    vim.fn.mkdir(undoDirectory, "p")                      --create it
end

-- ============ encoding ============
opt.encoding = "utf-8"                      --internal text encoding
opt.fileencoding = "utf-8"                  --encoding for saved files
opt.fileformats = { "unix", "dos", "mac" }  --support Unix, DOS, and Mac line endings

-- ============ backup & undo ============
opt.backup = false               --disable backup files
opt.writebackup = false          --disable backup before overwriting files
opt.swapfile = false             --disable swap files
opt.undofile = true              --enable persistent undo
opt.undodir = undoDirectory      --store undo history in custom directory

-- ============ clipboard ============
opt.clipboard = (has "win32" == 1 or has "win64" == 1)
    and "unnamed"                --use Windows system clipboard
    or "unnamedplus"             --use system clipboard on other OSes

-- ============ mouse ============
opt.mouse = ""                   --disable mouse support

-- ============ command Line ============
opt.cmdheight = 1                --height of command line area
opt.showcmd = false              --don’t show command in last line
opt.showmode = false             --don’t show current mode

-- ============ completion ============
opt.completeopt = { "menu", "menuone", "noselect" } -- Completion menu behavior
opt.pumheight = 12              --limit popup menu height

-- ============ timing ============
opt.updatetime = 210            --faster update time for CursorHold/autocommands
opt.timeoutlen = 500            --time to wait for mapped sequence to complete (ms)

-- ============ behavior ============
opt.confirm = true              --ask for confirmation when closing unsaved buffers
opt.autoread = true             --auto reload files changed outside Vim

-- ============ search ============
opt.hlsearch = true             --highlight search results
opt.incsearch = true            --show matches while typing
opt.showmatch = true            --highlight matching brackets
opt.ignorecase = true           --ignore case when searching
opt.smartcase = true            --ignore case unless search has uppercase letters
opt.wrapscan = true             --continue searching from the top when reaching the bottom

-- ============ indentation ============
opt.tabstop = 4                 --number of spaces per tab
opt.shiftwidth = 4              --indent width
opt.softtabstop = 4             --spaces per <Tab> when inserting
opt.expandtab = true            --convert tabs to spaces
opt.autoindent = true           --copy indent from current line when starting new line
opt.smartindent = true          --smarter auto-indentation
opt.shiftround = true           --round indent to nearest multiple of shiftwidth

-- ============ wrapping ============
opt.wrap = true                 --enable line wrapping
opt.linebreak = true            --wrap lines at word boundaries
opt.breakindent = true          --preserve indent when wrapping
opt.textwidth = 0               --don’t automatically wrap text
opt.wrapmargin = 3              --margin before wrapping text
opt.formatoptions = "jcrqlnt"   --fine-tune automatic formatting options
opt.lazyredraw = true           --don’t redraw while executing macros for speed
opt.synmaxcol = 120             --limit syntax highlight to first 120 columns

-- ============ display ============
opt.number = true               --show absolute line numbers
opt.relativenumber = true       --show relative line numbers
opt.scrolloff = 5               --keep 5 lines visible above/below cursor
opt.sidescrolloff = 5           --keep 5 columns visible left/right of cursor
opt.splitbelow = true           --open horizontal splits below current window
opt.splitright = true           --open vertical splits to the right
opt.background = "dark"         --optimize colors for dark backgrounds
opt.termguicolors = true        --enable true color support
opt.cursorline = true           --highlight current line
opt.cursorcolumn = true         --highlight current column
opt.signcolumn = "yes"          --always show the sign column
opt.colorcolumn = "120"         --highlight column 120 for guide

-- ============ status & tab lines ============
opt.laststatus = 3              --global status line
opt.showtabline = 1             --show tabline only if there are multiple tabs

-- ============ concealing ============
opt.conceallevel = 0            --disable concealing
opt.concealcursor = ""          --disable concealment while editing

-- ============ fill characters ============
opt.fillchars = {
    fold = "",                 --fold placeholder character
    foldopen = "",             --icon for open folds
    foldclose = "",            --icon for closed folds
    foldsep = "󰇙",              --fold separator
    diff = "",                 --character used in diff view
    eob = " ",                  --remove tildes (~) at end of buffer
}

-- ============ folding ============
opt.foldenable = true           --enable code folding
opt.foldlevel = 99              --open all folds by default
opt.foldnestmax = 99            --maximum nested folds
opt.foldminlines = 1            --minimum lines to create a fold
opt.foldcolumn = "1"            --show fold column

-- ============ window size ============
opt.winminheight = 1            --minimum window height
opt.winminwidth = 1             --minimum window width
opt.winheight = 12              --preferred window height
opt.winwidth = 30               --preferred window width

-- ============ spell checking ============
opt.spell = true                --enable spell checking
opt.spelllang = { "en_us" }     --use U.S. English dictionary

-- ============ session ============
opt.sessionoptions = {          --save options in sessions
    "buffers",                  --open buffers
    "curdir",                   --current directory
    "tabpages",                 --tabs
    "winsize",                  --window sizes
    "globals",                  --global variables
    "skiprtp",                  --skip runtime path
}
