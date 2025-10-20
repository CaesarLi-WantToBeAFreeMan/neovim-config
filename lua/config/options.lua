--shorthand
local opt = vim.opt                                 --Neovim options
local undo_dir = vim.fn.stdpath("data") .. "/undo"  --path for persistent undo files

--create undo directory if it doesn't exist
if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(undo_dir, "p")                     --ensure undo directory exists
end

-- ============ encoding ============
opt.encoding = "utf-8"                              --internal text encoding
opt.fileencoding = "utf-8"                          --save files in UTF-8 encoding
opt.fileformats = {"unix", "dos", "mac"}            --support multiple line-ending formats

-- ============ backup & undo ============
opt.backup = false                                  --disable backup files
opt.swapfile = false                                --disable swap files
opt.undofile = true                                 --enable persistent undo
opt.undodir = undo_dir                              --store undo history in custom directory

-- ============ clipboard ============
opt.clipboard = vim.fn.has("win32") == 1
    and "unnamed"                                   --use Windows system clipboard(unnamed)
    or "unnamedplus"                                --use Unix-like OS clipboard(unnamedplus)

-- ============ mouse ============
opt.mouse = ""                                      --disable mouse support

-- ============ command Line ============
opt.cmdheight = 1                                   --height of command line
opt.showcmd = false                                 --hide command display
opt.showmode = false                                --hide current mode display

-- ============ completion ============
opt.completeopt = {"menu", "menuone", "noselect"}   --configure completion menu behavior
opt.pumheight = 12                                  --limit popup menu height to 12 items

-- ============ timing ============
opt.updatetime = 210                                --faster undate time for CursorHold in ms
opt.timeoutlen = 500                                --time to wait for mapped sequences in ms

-- ============ behavior ============
opt.confirm = true                                  --prompts confirmation for unsaved buffers
opt.autoread = true                                 --auto-load files changed externally

-- ============ search ============
opt.hlsearch = true                                 --highlight search results
opt.ignorecase = true                               --ignore case in searches
opt.smartcase = true                                --case sensitive if search contains uppercase
opt.wrapscan = true                                 --loops search back to top

-- ============ indentation ============
opt.tabstop = 4                                     --set tab width to 4 spaces
opt.shiftwidth = 4                                  --set indent width to 4 spaces
opt.softtabstop = 4                                 --set spaces per tab in insert mode
opt.expandtab = true                                --convert tabs to spaces
opt.autoindent = true                               --copy indent from previous line
opt.smartindent = true                              --enable smarter auto-indentation
opt.shiftround = true                               --round indent to nearest shiftwidth

-- ============ wrapping ============
opt.wrap = true                                     --enable line wrapping
opt.linebreak = true                                --wrap lines at word boundaries
opt.breakindent = true                              --preserve indent on wrapped lines
opt.wrapmargin = 3                                  --set margin before wrapping
opt.formatoptions = "jcrqlnt"                       --configure formatting
opt.lazyredraw = true                               --skip redraw during macros for speed
opt.synmaxcol = 120                                 --limit syntax highlight to 120 columns

-- ============ display ============
opt.number = true                                   --show absolute line numbers
opt.relativenumber = true                           --show relative line numbers
opt.scrolloff = 5                                   --keep 5 lines visible above/below cursor
opt.sidescrolloff = 5                               --keep 5 columns visible left/right of cursor
opt.splitbelow = true                               --open horizontal splits below
opt.splitright = true                               --open vertical splits to the right
opt.termguicolors = true                            --enable true color support
opt.cursorline = true                               --highlight current line
opt.cursorcolumn = true                             --highlight current column
opt.signcolumn = "yes"                              --always show sign column
opt.colorcolumn = "120"                             --highlight column 120 as guide

-- ============ status & tabline ============
opt.laststatus = 3                                  --use global statusline
opt.showtabline = 1                                 --show tabline only with multiple tabs

-- ============ folding ============
opt.foldenable = true                               --enable code folding
opt.foldlevel = 99                                  --open all folds by default
opt.foldcolumn = "1"                                --show fold column
opt.fillchars = {                                   --custom fold and diff characters
    fold = "",                                     --fold placeholder character
    foldopen = "",                                 --icon for open folds
    foldclose = "",                                --icon for closed folds
    foldsep = "󰇙",                                  --fold separator
    diff = "",                                     --character used in diff view
    eob = " ",                                      --remove tildes (~) at end of buffer
}

-- ============ window size ============
opt.winminheight = 1                                --set minimum window height
opt.winminwidth = 1                                 --set minimum window width
opt.winheight = 12                                  --set preferred window height
opt.winwidth = 30                                   --set preferred window width

-- ============ spell checking ============
opt.spell = true                                    --enable spell checking
opt.spelllang = {"en_us"}                           --use U.S. English dictionary

-- ============ session ============
opt.sessionoptions = {                              --save options in sessions
    "blank",                                        --empty windows
    "buffers",                                      --open buffers
    "curdir",                                       --current directory
    "folds",                                        --folds
    "help",                                         --help window
    "tabpages",                                     --tabs
    "winpos",                                       --window positions
    "winsize",                                      --window sizes
}
