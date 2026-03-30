# Caesar James LEE's Neovim Configurations

A **modern**, **cyberpunk-themed** `Neovim` configuration built for **full-stack** development, competitive programming, and
daily editing.

---

> [!NOTE]
> You need to install `Neovim v.0.11+` to use

---

## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
3. [Key Mappings](#key-mappings)
4. [Plugins](#plugins)
5. [LSP Servers & Tools](#lsp-servers-tools)
6. [Checking Health](#checking-health)

---

## Requirements

### Mandatory

|       tool       |           purpose            |            `Microsoft Windows`             |                    `Apple macOS`                    |                 `Linux`                 |
| :--------------: | :--------------------------: | :----------------------------------------: | :-------------------------------------------------: | :-------------------------------------: |
| `Neovim v.0.11+` |         text editor          |       `winget install Neovim.Neovim`       |                `brew install neovim`                |        `sudo apt install neovim`        |
|      `Git`       |       version control        |          `winget install Git.Git`          |                 `brew install git`                  |         `sudo apt install git`          |
|  `Node.js 18+`   | LSP servers, formatters, DAP |       `winget install OpenJs.NodeJS`       |                 `brew install node`                 |      `sudo apt install nodejs npm`      |
|    `Python 3`    |  LSP, formatters, providers  |      `winget install Python.Python3`       |                `brew install python`                | `sudo apt install python3 python3-pip`  |
|  a `nerd font`   |            icons             | [nerdfonts.com](https://www.nerdfonts.com) | `brew install --cask font-jetbrains-mono-nerd-font` | `sudo apt install fonts-jetbrains-mono` |

> [!NOTE]
> for `nerd font`, you can select a font what you like if you don't like `jetbrains mono nerd font`

### Strongly Recommended

|      tool      |                 purpose                  |           `Microsoft Windows`            |     `Apple macOS`      |          `Linux`           |
| :------------: | :--------------------------------------: | :--------------------------------------: | :--------------------: | :------------------------: |
|   `ripgrep`    |     fast text search (`<leader>ft`)      | `winget install BurntSushi.ripgrep.MSVC` | `brew install ripgrep` | `sudo apt install ripgrep` |
|      `fd`      | file finder, `Snacks` pickers & projects |       `winget install sharkdp.fd`        |   `brew install fd`    | `sudo apt install fd-find` |
|   `lazygit`    |     `TUI` git client (`<leader>gL`)      | `winget install JessseDuffield.lazygit`  | `brew install lazygit` | `sudo apt install lazygit` |
| `PowerShell 7` |   better shell on `Microsoft Windows`    |  `winget install Microsoft.PowerShell`   |           -            |             -              |

### Optional (`LSP`)

|        tool         |        purpose         |               `Microsoft Windows`               |         `Apple macOS`          |                              `Linux`                              |
| :-----------------: | :--------------------: | :---------------------------------------------: | :----------------------------: | :---------------------------------------------------------------: |
|      `GCC/G++`      |    `C/C++` compiler    |   [MinGW](https://winget.run/pkg/MSYS2/MSYS2)   |       `brew install gcc`       |                `sudo apt install build-essential`                 |
|       `CMake`       | `C++` project manager  |         `winget install Kitware.CMake`          |      `brew install cmake`      |                     `sudo apt install cmake`                      |
|     `Java JDK`      |       `Java JDK`       | `winget install EclipseAdoptium.Temurin.21.JDK` |     `brew install temurin`     |                 `sudo apt install openjdk-21-jdk`                 |
|       `Maven`       | `Java` project manager |          `winget install Apache.Maven`          |      `brew install maven`      |                     `sudo apt install maven`                      |
|      `Gradle`       | `Java` project manager |         `winget install Gradle.Gradle`          |     `brew install gradle`      |                     `sudo apt install gradle`                     |
|       `black`       |   `Python` formatter   |               `pip install black`               |      `pip install black`       |                        `pip install black`                        |
|       `isort`       | `Python` import sorter |               `pip install isort`               |      `pip install isort`       |                        `pip install isort`                        |
|       `Rust`        |         `Rust`         |        `winget install Rustlang.Rustup`         |      `brew install rust`       | `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \| sh` |
|        `Go`         |          `Go`          |           `winget install GoLang.Go`            |       `brew install go`        |                     `sudo apt install golang`                     |
|       `shfmt`       |   `Shell` formatter    |  [shfmt](https://github.com/mvdan/sh/releases)  |      `brew install shfmt`      |                     `sudo apt install shfmt`                      |
|   `sql-formatter`   |    `SQL` formatter     |         `npm install -g sql-formatter`          | `npm install -g sql-formatter` |                  `npm install -g sql-formatter`                   |
| `MikTex`/`Tex Live` |    `LaTeX` compiler    |          [MikTex](https://miktex.org)           |     `brew install mactex`      |                  `sudo apt install texlive-full`                  |
|    `latexindent`    |   `LaTeX` formatter    |              `MiKTeX` includes it               |    `brew install basictex`     |              `sudo apt install texlive-extra-utils`               |
|      `Docker`       |     dockerfile LSP     |          [docker](https://docker.com)           |  `brew install --cask docker`  |                   `sudo apt install docker.io`                    |

> [!NOTE]
> you can install some/all of these optional tools, if you haven't developed using a language
> you can google if your developed language isn't appear in the above table

---

## Installation

### `Apple macOS`/`Linux`

```bash
mv ~/.config/nvim ~/.config/nvim.bak #backup existing config
git clone https://github.com/CaesarLi-WantToBeAFreeMan/neovim-config ~/.config/nvim #clone this repo
nvim #open Neovim, and lazy.nvim installs all plugins automatically
```

### `Microsoft Windows`

```pwsh
rename %LOCALAPPDATA%\nvim to %LOCALAPPDATA%\nvim.bak #backup existing config
git clone https://github.com/CaesarLi-WantToBeAFreeMan/neovim-config %LOCALAPPDATA%\nvim #clone this repo
nvim #open Neovim, and lazy.nvim installs all plugins automatically
```

### Inside `Neovim`

```vim
:MasonUpdate "install LSP servers, formatters, DAP adapters via Mason
:Mason "you can install your favorite LSP/formatter/DAP/Linter
:q "you know, the most asked question: how to quit vim, lol
```

> [!NOTE]
> if you wanna use `cmd` instead of `PowerShell` on `Microsoft Windows`
> please google alternative commands or ask an AI agent to convert `PowerShell` commands to `cmd`

---

## Key Mappings

> [!NOTE]
> my `leader key` is `\\` (backslash), you can change it in `init.lua`
> mode: `n`: normal, `i`: insert, `v`: visual, `c`: command, `t`: terminal

### Text Editing

|        key         |  mode   |              description               |
| :----------------: | :-----: | :------------------------------------: |
|      `<Tab>`       |   `n`   |              insert a tab              |
|     `<Space>`      |   `n`   |             insert a space             |
|      `<Del>`       |   `n`   |       delete previous character        |
|       `<BS>`       |   `n`   |        delete current character        |
|      `<C-n>`       |   `n`   |        insert a new line below         |
|      `<C-p>`       |   `n`   |        insert a new line above         |
| `<leader><leader>` | `i`/`c` |         insert a backslash `\`         |
|    `<leader>d`     |   `n`   | delete without polluting yank register |
|    `<leader>D`     |   `n`   |   delete to end of line without yank   |
|    `<leader>j`     | `n`/`v` |        move line/selection down        |
|    `<leader>k`     | `n`/`v` |         move line/selection up         |

### Clipboard & Yank

|   key   |  mode   |                description                |
| :-----: | :-----: | :---------------------------------------: |
|   `y`   | `n`/`v` |         yank (tracked in history)         |
|   `p`   | `n`/`v` |             put after cursor              |
|   `P`   | `n`/`v` |             put before cursor             |
|  `gp`   | `n`/`v` |             gput after cursor             |
|  `gP`   | `n`/`v` |            gput before cursor             |
| `<A-p>` |   `n`   | cycle yank history forward (after paste)  |
| `<A-n>` |   `n`   | cycle yank history backward (after paste) |

### Scroll & Navigation

|   key   | mode |             description              |
| :-----: | :--: | :----------------------------------: |
| `<C-d>` | `n`  | scroll down half page, cursor to top |
| `<C-u>` | `n`  |  scroll up half page, cursor to top  |
| `<C-f>` | `n`  | scroll down full page, cursor to top |
| `<C-b>` | `n`  |  scroll up full page, cursor to top  |
| `<C-e>` | `n`  | scroll down one line, cursor to top  |
| `<C-y>` | `n`  |  scroll up one line, cursor to top   |
| `<C-o>` | `n`  |     jump backward, cursor to top     |
| `<C-i>` | `n`  |     jump forward, cursor to top      |

### Search

|   key   | mode |                 description                 |
| :-----: | :--: | :-----------------------------------------: |
| `<Esc>` | `n`  |           clear search highlight            |
|   `*`   | `n`  | highlight word under cursor without jumping |
|   `/`   | `v`  |     search within visual selection only     |

### Windows & Splits

|     key      | mode |           description            |
| :----------: | :--: | :------------------------------: |
|   `<C-h>`    | `n`  |        go to left window         |
|   `<C-j>`    | `n`  |        go to lower window        |
|   `<C-k>`    | `n`  |        go to upper window        |
|   `<C-l>`    | `n`  |        go to right window        |
|   `<A-h>`    | `n`  | increase window width (+2 cols)  |
|   `<A-j>`    | `n`  | decrease window height (-2 rows) |
|   `<A-k>`    | `n`  | increase window height (+2 rows) |
|   `<A-l>`    | `n`  | decrease window width (-2 cols)  |
| `<leader>w=` | `n`  |     equalize all split sizes     |
| `<leader>wx` | `n`  |   swap current split with next   |

### Tabs

|     key      | mode |     description      |
| :----------: | :--: | :------------------: |
|     `]t`     | `n`  |       next tab       |
|     `[t`     | `n`  |     previous tab     |
| `<leader>tn` | `n`  |       new tab        |
| `<leader>tx` | `n`  |  close current tab   |
| `<leader>tX` | `n`  | close all other tabs |

### Buffers

|     key      | mode |         description         |
| :----------: | :--: | :-------------------------: |
|     `]b`     | `n`  |         next buffer         |
|     `[b`     | `n`  |       previous buffer       |
| `<leader>bn` | `n`  |      new empty buffer       |
| `<leader>bx` | `n`  |    close current buffer     |
| `<leader>bX` | `n`  |   close all other buffers   |
| `<leader>bd` | `n`  | safe delete buffer (Snacks) |
| `<leader>br` | `n`  | rename / move current file  |

### Toggles

|     key      |  mode   |                description                 |
| :----------: | :-----: | :----------------------------------------: |
| `<leader>tw` | `n`/`i` |              toggle line wrap              |
| `<leader>tl` | `n`/`i` |            toggle line numbers             |
| `<leader>tL` | `n`/`i` |        toggle relative line numbers        |
| `<leader>ts` | `n`/`i` |            toggle spell checker            |
| `<leader>td` | `n`/`i` |         toggle inline diagnostics          |
| `<leader>th` |   `n`   | toggle LSP inlay hints (when LSP attached) |
| `<leader>tf` |   `n`   |           toggle format on save            |
| `<leader>tz` |   `n`   |              toggle zen mode               |
| `<leader>tZ` |   `n`   |              toggle zoom mode              |
| `<leader>tt` |   `n`   |              toggle terminal               |

### Find/Picker

|     key      | mode |           description            |
| :----------: | :--: | :------------------------------: |
| `<leader>ff` | `n`  |            find files            |
| `<leader>ft` | `n`  | find text in session (live grep) |
| `<leader>fT` | `n`  |    find text in open buffers     |
| `<leader>fl` | `n`  |   find lines in current buffer   |
| `<leader>fb` | `n`  |        find open buffers         |
| `<leader>fr` | `n`  |          find registers          |
| `<leader>fm` | `n`  |            find marks            |
| `<leader>fj` | `n`  |            find jumps            |
| `<leader>fk` | `n`  |           find keymaps           |
| `<leader>fh` | `n`  |          find help tags          |
| `<leader>fH` | `n`  |      find highlight groups       |
| `<leader>fi` | `n`  |            find icons            |
| `<leader>fc` | `n`  |          find commands           |
| `<leader>fa` | `n`  |        find autocommands         |
| `<leader>fp` | `n`  |       find plugins (Lazy)        |
| `<leader>fq` | `n`  |       find quickfix items        |
| `<leader>fL` | `n`  |     find location list items     |
| `<leader>fR` | `n`  |         resume last find         |
| `<leader>fC` | `n`  |        find colorschemes         |
| `<leader>fd` | `n`  |     find buffer diagnostics      |
| `<leader>fD` | `n`  |    find workspace diagnostics    |
| `<leader>fs` | `n`  |      find sessions/projects      |
| `<leader>fn` | `n`  |     find Neovim config files     |

### History

|     key      | mode |     description      |
| :----------: | :--: | :------------------: |
| `<leader>hc` | `n`  |   command history    |
| `<leader>hn` | `n`  | notification history |
| `<leader>hs` | `n`  |    search history    |
| `<leader>hu` | `n`  |     undo history     |

### Git

|     key      |  mode   |           description           |
| :----------: | :-----: | :-----------------------------: |
| `<leader>gb` |   `n`   |          git branches           |
| `<leader>gl` |   `n`   |             git log             |
| `<leader>gs` |   `n`   |           git status            |
| `<leader>gB` | `n`/`v` |  git browse (open in browser)   |
| `<leader>gL` |   `n`   |          open lazygit           |
|     `]r`     | `n`/`t` |   jump to next word reference   |
|     `[r`     | `n`/`t` | jump to previous word reference |

---

### LSP

|     key      |  mode   |       description       |
| :----------: | :-----: | :---------------------: |
|     `gd`     |   `n`   |    go to definition     |
|     `gD`     |   `n`   |    go to declaration    |
|     `gi`     |   `n`   |  go to implementation   |
|     `gr`     |   `n`   |   find all references   |
|     `gt`     |   `n`   |  go to type definition  |
|     `gc`     |   `n`   |  go to incoming calls   |
|     `gC`     |   `n`   |  go to outgoing calls   |
|     `gs`     |   `n`   |  find document symbols  |
|     `gS`     |   `n`   | find workspace symbols  |
|     `K`      |   `n`   |   hover documentation   |
|     `gK`     |   `n`   |     signature help      |
|   `<C-s>`    |   `i`   |     signature help      |
| `<leader>lr` |   `n`   |      rename symbol      |
| `<leader>la` | `n`/`v` | code action (pretty UI) |
| `<leader>ll` |   `n`   |     LSP server info     |
| `<leader>lf` |   `n`   |   format current file   |

### Diagnostics

|     key      | mode |        description        |
| :----------: | :--: | :-----------------------: |
|     `]d`     | `n`  |      next diagnostic      |
|     `[d`     | `n`  |    previous diagnostic    |
|     `]e`     | `n`  |        next error         |
|     `[e`     | `n`  |      previous error       |
|     `]w`     | `n`  |       next warning        |
|     `[w`     | `n`  |     previous warning      |
|     `]h`     | `n`  |         next hint         |
|     `[h`     | `n`  |       previous hint       |
|     `]i`     | `n`  |         next info         |
|     `[i`     | `n`  |       previous info       |
| `<leader>dn` | `n`  | dismiss all notifications |

### `Trouble` (Diagnostics Panel)

|   key    | mode |               description               |
| :------: | :--: | :-------------------------------------: |
|  `<F2>`  | `n`  |        toggle LSP symbols panel         |
| `<S-F2>` | `n`  | toggle LSP definitions/references panel |
| `<C-F2>` | `n`  |     toggle buffer diagnostics panel     |

#### Inside Trouble panel:

|    key    |          description           |
| :-------: | :----------------------------: |
|  `<CR>`   |  jump to item and close panel  |
|    `h`    |    open in horizontal split    |
|    `v`    |     open in vertical split     |
| `o` / `O` |   open/open fold recursively   |
| `c` / `C` |  close/close fold recursively  |
| `x` / `X` | toggle/toggle fold recursively |

### Debugger (DAP)

|     key      |  mode   |        description         |
| :----------: | :-----: | :------------------------: |
|    `<F9>`    |   `n`   |  start/continue debugging  |
|   `<S-F9>`   |   `n`   |       stop debugger        |
|   `<C-F9>`   |   `n`   |       run to cursor        |
|   `<F10>`    |   `n`   |         step over          |
|   `<F11>`    |   `n`   |         step into          |
|  `<S-F11>`   |   `n`   |          step out          |
| `<leader>db` |   `n`   |     toggle breakpoint      |
| `<leader>dB` |   `n`   | set conditional breakpoint |
| `<leader>dl` |   `n`   |       set log point        |
| `<leader>dL` |   `n`   | re-run last debug session  |
| `<leader>dx` |   `n`   |   clear all breakpoints    |
| `<leader>du` |   `n`   |   toggle debug UI panels   |
| `<leader>de` | `n`/`v` |    evaluate expression     |
| `<leader>df` |   `n`   |    float a debug panel     |
| `<leader>dr` |   `n`   |      open debug REPL       |
| `<leader>dp` |   `n`   |      pause execution       |

### Code Runner

|   key    | mode |                  description                   |
| :------: | :--: | :--------------------------------------------: |
|  `<F5>`  | `n`  |        smart run (single file/project)         |
| `<S-F5>` | `n`  | run current file only (ignore project context) |

### Project Priority

1. `CMake`/`QT`
2. `MFC`
3. `Maven`/`Spring Boot`
4. `Gradle`/`Spring Boot`
5. plain `Java`
6. `Django`/`Python`
7. `Vite`
8. `Node`/`npm`
9. static `HTML`
10. `Cargo`
11. `Go` module
12. single file

### File Explorer (`Neo-tree`)

|   key    | mode |         description         |
| :------: | :--: | :-------------------------: |
|  `<F1>`  | `n`  | toggle file system explorer |
| `<S-F1>` | `n`  | toggle git status explorer  |
| `<C-F1>` | `n`  | toggle buffer list explorer |

#### Inside `Neo-tree`:

|          key           |           description            |
| :--------------------: | :------------------------------: |
| `<Space>` / `x` / `za` |           toggle node            |
|  `<CR>` / `o` / `zo`   |    open file / expand folder     |
|       `O` / `zO`       |      open node recursively       |
|       `X` / `zA`       |     toggle node recursively      |
|       `c` / `zc`       |            close node            |
|       `C` / `zC`       |      close node recursively      |
|          `h`           |     open in horizontal split     |
|          `v`           |      open in vertical split      |
|          `t`           |         open in new tab          |
|          `w`           |     open with window picker      |
|          `p`           |       toggle file preview        |
|          `r`           |         rename filename          |
|          `R`           |         rename extension         |
|          `a`           |         add file/folder          |
|          `A`           |            add folder            |
|          `m`           |            move node             |
| `d` / `<BS>` / `<Del>` |           delete node            |
|        `<C-x>`         |         cut to clipboard         |
|        `<C-y>`         |        copy to clipboard         |
|        `<C-p>`         |       paste from clipboard       |
|        `<C-c>`         |         clear clipboard          |
|        `<C-r>`         |           refresh tree           |
|          `/`           |         fuzzy find nodes         |
|          `#`           |            fuzzy sort            |
|          `u`           |    navigate up one directory     |
|          `s`           |      set as root directory       |
|      `[g` / `]g`       |   jump to prev/next git change   |
|          `=`           | toggle full width / normal width |
|      `<leader>h`       |       toggle hidden files        |
|          `?`           |            show help             |
|     `q` / `<Esc>`      |          close Neo-tree          |

### Surround (`mini.surround`)

|        key         |       description        |
| :----------------: | :----------------------: |
| `sa{motion}{char}` |     add surrounding      |
|     `sd{char}`     |    delete surrounding    |
|  `sc{char}{char}`  |    change surrounding    |
|     `sf{char}`     | find surrounding (right) |
|     `sF{char}`     | find surrounding (left)  |
|     `sh{char}`     |  highlight surrounding   |

> [!HELP]
> `saiw{`: `hello world` -> `{ hello world }`
> `sa3e]`: `hi hello world` -> `[hi hello world]`
> `sd"`: `"hello world"` -> `hello world`

### Text Objects (mini.ai)

> [!INFO]
> these work with `v`, `d`, `c`, `y` + `a`/`i`:

|        object        | around | inside |
| :------------------: | :----: | :----: |
|       function       |  `af`  |  `if`  |
|        class         |  `ac`  |  `ic`  |
| block/condition/loop |  `ab`  |  `ib`  |
|    tag (HTML/JSX)    |  `at`  |  `it`  |
|      parameter       |  `ap`  |  `ip`  |
|       comment        |  `a/`  |  `i/`  |
|    digit sequence    |  `ad`  |  `id`  |

### Increment/Decrement (`dial.nvim`)

|   key    | mode |         description          |
| :------: | :--: | :--------------------------: |
| `<C-a>`  | `n`  | increment value under cursor |
| `<C-x>`  | `n`  | decrement value under cursor |
| `g<C-a>` | `n`  |     sequential increment     |
| `g<C-x>` | `n`  |     sequential decrement     |
| `<C-a>`  | `v`  |     increment selection      |
| `<C-x>`  | `v`  |     decrement selection      |

### `Treesitter`

|   key    | mode |              description               |
| :------: | :--: | :------------------------------------: |
|  `<CR>`  | `n`  |   start/expand treesitter selection    |
| `<S-CR>` | `n`  |      shrink treesitter selection       |
|  `<BS>`  | `n`  |       expand selection to scope        |
|   `]f`   | `n`  |      jump to next function start       |
|   `[f`   | `n`  |    jump to previous function start     |
|   `]c`   | `n`  |        jump to next class start        |
|   `[c`   | `n`  |      jump to previous class start      |
|   `[x`   | `n`  | jump to context (current scope header) |
|   `]x`   | `n`  |         jump back from context         |

### Markdown

|     key     | mode |           description           |
| :---------: | :--: | :-----------------------------: |
| `<leader>v` | `n`  |  toggle inline markdown render  |
| `<leader>V` | `n`  | toggle browser markdown preview |

### Date Structure and Algorithms (DSA) / Competitive Programming

#### `LeetCode`

|     key      |      description       |
| :----------: | :--------------------: |
|    `<F3>`    |   open LeetCode home   |
|   `<S-F3>`   |  test current problem  |
|   `<C-F3>`   | submit current problem |
|   `<A-F3>`   |     close LeetCode     |
| `<leader>lp` |      problem list      |
| `<leader>lc` |        console         |
| `<leader>li` |      problem info      |
| `<leader>lt` |       open tabs        |
| `<leader>lL` |    change language     |

#### CompetiTest (`Codeforces`, `USACO`, `AtCoder` and so on)

|     key      |       description       |
| :----------: | :---------------------: |
| `<leader>ca` |      add test case      |
| `<leader>ce` |     edit test case      |
| `<leader>cd` |    delete test case     |
| `<leader>cr` |  compile, run and test  |
| `<leader>cR` | run without recompiling |
| `<leader>cs` |      show test UI       |
| `<leader>cp` |     receive problem     |
| `<leader>cc` |     receive contest     |

> [!NOTE]
> you need to install `competitive companion` extension in your browser
> to receive problems / contests

#### Performance Profiling (`perfanno.nvim`)

|     key      |         description          |
| :----------: | :--------------------------: |
| `<leader>pf` | annotate file with perf data |
| `<leader>pF` |      annotate function       |
| `<leader>ps` |      annotate selection      |
| `<leader>ph` |     show hottest symbols     |
| `<leader>pl` |      show hottest lines      |
| `<leader>pc` |     show hottest callers     |
| `<leader>pt` |      toggle annotations      |
| `<leader>pe` |       pick perf event        |

### Search & Replace

|     key      |  mode   |             description             |
| :----------: | :-----: | :---------------------------------: |
| `<leader>sr` | `n`/`v` | search & replace (current filetype) |
| `<leader>sR` | `n`/`v` |    search & replace (all files)     |
| `<leader>sw` |   `n`   | search & replace word under cursor  |

### Command Line

|   key   | mode |            description             |
| :-----: | :--: | :--------------------------------: |
| `<C-j>` | `c`  |     next command history entry     |
| `<C-k>` | `c`  |   previous command history entry   |
|  `%%`   | `c`  | expand to current file's directory |

### Other

|     key      | mode |              description              |
| :----------: | :--: | :-----------------------------------: |
|   `<A-w>`    | `i`  | fast-wrap: wrap next word in autopair |
| `<leader>nn` | `n`  |           open Neovim news            |
| `<leader>fo` | `n`  |              find TODOs               |
|     `]o`     | `n`  |           jump to next TODO           |
|     `[o`     | `n`  |         jump to previous TODO         |

## Plugins

### Plugin Manager

|                     plugin                      |            description             |
| :---------------------------------------------: | :--------------------------------: |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | modern plugin manager for `Neovim` |

### UI & Theme

|                                               plugin                                                |                                                      description                                                       |
| :-------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------: |
|                  [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim)                  |                          colorscheme: "deep" dark variant with cyberpunk highlight overrides                           |
|              [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)              |                status line with git diff counts, LSP diagnostic counts, cursor position, and live clock                |
|                [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)                |                                      buffer tab bar sorted by most recently used                                       |
|                      [folke/snacks.nvim](https://github.com/folke/snacks.nvim)                      | all-in-one plugin: dashboard, picker, terminal, notifier, indent guides, word highlighter, zen mode, lazygit, and more |
|                     [folke/trouble.nvim](https://github.com/folke/trouble.nvim)                     |                                 pretty diagnostics, symbols, and LSP reference panels                                  |
| [rachartier/tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim) |                              inline LSP diagnostics displayed beside the problematic code                              |
|            [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)            |                                         file type icons used throughout the UI                                         |

### File Management

|                                    plugin                                     |                                       description                                        |
| :---------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------: |
| [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | file explorer, buffer browser, and git status browser with full keybinding customization |

### Editor Enhancements

|                                                    plugin                                                     |                                       description                                       |
| :-----------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------: |
|                     [MagicDuck/grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim)                     |                search & replace across multiple files with live preview                 |
|                       [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)                       |             auto-close brackets, quotes, and tags using treesitter context              |
|                      [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)                      |                    auto-close and auto-rename HTML/XML/JSX/Vue tags                     |
|                   [echasnovski/mini.surround](https://github.com/echasnovski/mini.surround)                   |                   add, delete, and change surrounding characters/tags                   |
|                         [echasnovski/mini.ai](https://github.com/echasnovski/mini.ai)                         |      extended text objects: functions, classes, blocks, tags, parameters, comments      |
|                    [echasnovski/mini.comment](https://github.com/echasnovski/mini.comment)                    |        `gcc` toggle line comment, `gbc` block comment, context-aware in Vue/HTML        |
| [JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) |                  provide correct comment syntax for embedded languages                  |
|                            [monaqa/dial.nvim](https://github.com/monaqa/dial.nvim)                            |       enhanced `<C-a>`/`<C-x>` to cycle booleans, access modifiers, dates, semver       |
|                           [gbprod/yanky.nvim](https://github.com/gbprod/yanky.nvim)                           |           yank ring with history — cycle through previous yanks after pasting           |
|                    [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)                    | highlight `TODO`, `FIXME`, `BUG`, `HACK`, `NOTE`, `PERF`, `TEST` with sign column icons |
|            [rachartier/tiny-code-action.nvim](https://github.com/rachartier/tiny-code-action.nvim)            |                      prettier code action picker using `Telescope`                      |
|                       [RRethy/vim-illuminate](https://github.com/RRethy/vim-illuminate)                       |               auto-highlights other occurrences of the word under cursor                |

### Syntax & Treesitter

|                                                    plugin                                                     |                               description                               |
| :-----------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------: |
|             [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)             | syntax parsing for highlighting, indentation, folding, and text objects |
| [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) |                treesitter-based text objects and motions                |
|     [nvim-treesitter/nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)     |    shows current function/class/scope header pinned at top of window    |

### LSP & Completion

|                                            plugin                                             |                                   description                                   |
| :-------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------: |
|             [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)             |      install and manage LSP servers, formatters, linters, and DAP adapters      |
|   [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)   |          Bridge Mason and nvim-lspconfig for automatic server enabling          |
|               [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)               |                   default configurations for all LSP servers                    |
|                [b0o/SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim)                | `JSON`/`YAML` schema catalog for auto schema detection in `jsonls` and `yamlls` |
|                    [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                    |                                completion engine                                |
|                [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)                |                              LSP completion source                              |
|                  [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer)                  |                         buffer words completion source                          |
|                    [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)                    |                           file path completion source                           |
|                 [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)                 |                         command line completion source                          |
| [hrsh7th/cmp-nvim-lsp-signature-help](https://github.com/hrsh7th/cmp-nvim-lsp-signature-help) |                     function signature as completion source                     |
|                    [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)                    |                                 snippet engine                                  |
|        [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)        |               VSCode-style snippet collection for many languages                |
|                [onsails/lspkind.nvim](https://github.com/onsails/lspkind.nvim)                |                        LSP kind icons in completion menu                        |
|       [roginfarrer/cmp-css-variables](https://github.com/roginfarrer/cmp-css-variables)       |                  complete CSS custom properties (`--var-name`)                  |
|                  [folke/lazydev.nvim](https://github.com/folke/lazydev.nvim)                  |               improved `Lua LSP` for `Neovim` config development                |
| [luckasRanarison/tailwind-tools.nvim](https://github.com/luckasRanarison/tailwind-tools.nvim) |                 `Tailwind CSS` class color swatches and sorting                 |

### Formatting

|                              plugin                               |                       description                        |
| :---------------------------------------------------------------: | :------------------------------------------------------: |
| [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) | format on save with per-filetype formatter configuration |

### Debugging (`DAP`)

|                                        plugin                                         |                                  description                                   |
| :-----------------------------------------------------------------------------------: | :----------------------------------------------------------------------------: |
|           [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)           |                  Debug Adapter Protocol client: core debugger                  |
|            [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)            | visual debugger UI: variables, call stack, breakpoints, watches, REPL, console |
| [theHamsta/nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) |        show variable values inline next to the code as you step through        |
|           [nvim-neotest/nvim-nio](https://github.com/nvim-neotest/nvim-nio)           |                  async I/O library required by `nvim-dap-ui`                   |

### Colorization

|                                  plugin                                   |                                 description                                  |
| :-----------------------------------------------------------------------: | :--------------------------------------------------------------------------: |
| [Nvchad/nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua) | show color swatches behind hex codes, rgb(), hsl(), and Tailwind class names |

### Git

|                                plugin                                 |                          description                           |
| :-------------------------------------------------------------------: | :------------------------------------------------------------: |
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | git diff signs in the sign column, hunk navigation and staging |

### markdown

|                                                  plugin                                                   |                                description                                |
| :-------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------: |
| [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | render headings, code blocks, checkboxes, and tables inline in the buffer |
|              [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)              |               live-reloading markdown preview in a browser                |

### DSA & Competitive Programming

|                                 plugin                                  |                                   description                                    |
| :---------------------------------------------------------------------: | :------------------------------------------------------------------------------: |
|      [kawre/leetcode.nvim](https://github.com/kawre/leetcode.nvim)      |     `LeetCode` client: fetch problems, test, and submit directly from Neovim     |
| [xeluxee/competitest.nvim](https://github.com/xeluxee/competitest.nvim) | test runner for competitive programming (`Codeforces`, `USACO`, `AtCoder`, etc.) |
|  [t-troebst/perfanno.nvim](https://github.com/t-troebst/perfanno.nvim)  |         visualize `perf` profiling output as inline hotspot annotations          |

## LSP Servers & Tools

### LSP Servers

|              server               |                languages                 |
| :-------------------------------: | :--------------------------------------: |
|             `clangd`              |                  C, C++                  |
|              `jdtls`              |            Java (with Lombok)            |
|             `pyright`             |                  Python                  |
|             `lua_ls`              |                   Lua                    |
|              `html`               |                   HTML                   |
|              `cssls`              |             CSS, SCSS, LESS              |
|           `tailwindcss`           |               Tailwind CSS               |
|            `emmet_ls`             |         HTML/CSS Emmet snippets          |
|              `ts_ls`              |          JavaScript, TypeScript          |
|              `vtsls`              |  TypeScript enhanced (Vue integration)   |
|              `volar`              |                  Vue 3                   |
|             `eslint`              | JavaScript/TypeScript linting & auto-fix |
|             `jsonls`              |               JSON, JSONC                |
|             `yamlls`              |                   YAML                   |
|             `lemminx`             |         XML, pom.xml (Maven XSD)         |
|              `taplo`              |                   TOML                   |
|            `dockerls`             |                Dockerfile                |
| `docker_compose_language_service` |            docker-compose.yml            |
|            `marksman`             |                 Markdown                 |
|             `texlab`              |                  LaTeX                   |
|             `bashls`              |               Bash, Shell                |
|              `vimls`              |                Vimscript                 |

### Formatters

|    formatter    |                        languages                        |
| :-------------: | :-----------------------------------------------------: |
| `clang-format`  |                      C, C++, Java                       |
|   `prettier`    | HTML, CSS, SCSS, JS, TS, Vue, JSON, YAML, Markdown, XML |
|    `stylua`     |                           Lua                           |
|     `black`     |                         Python                          |
|     `isort`     |                    Python (imports)                     |
| `sql-formatter` |                           SQL                           |
|     `shfmt`     |                      Shell scripts                      |
|     `taplo`     |                          TOML                           |
|  `latexindent`  |                          LaTeX                          |

### DAP Adapters (Debuggers)

|       adapter        |                  languages                   |
| :------------------: | :------------------------------------------: |
|      `codelldb`      |                    C, C++                    |
| `java-debug-adapter` |                     Java                     |
|     `java-test`      |                 Java (JUnit)                 |
|  `js-debug-adapter`  | JavaScript, TypeScript, React, Vue, HTML/CSS |

## Checking Health

```vim
:checkhealth "full health check
:checkhealth snacks "snacks-specific
:checkhealth mason "Mason & tool availability
:ConformInfo "formatter status
```
