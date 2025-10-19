return{
    "nvim-neo-tree/neo-tree.nvim",      --modern file explorer
    branch = "v3.x",                    --use stable v3.x branch
    dependencies = {
        "nvim-lua/plenary.nvim",        --lua utility library for Neovim
        "nvim-tree/nvim-web-devicons",  --file icons
        "MunifTanjim/nui.nvim",         --ui components
    },
    keys = {
        {"<F1>",    "<cmd>Neotree toggle<CR>",      desc = "toggle Neo-tree",               mode = "n"},
        {"<F1>g",   "<cmd>Neotree git_status<CR>",  desc = "show git status in Neo-tree",   mode = "n"},
        {
            "<F1>b",
            function()
                vim.cmd("Neotree close")--close Neo-tree first
                vim.defer_fn(
                    function()
                        vim.cmd("Neotree buffers")
                    end,
                    50
                )
            end,
            desc = "show buffers in Neo-tree",
            mode = "n"
        },
    },
    config = function()
        vim.g.loaded_netrw = 1              --disable netrw
        vim.g.loaded_netrwPlugin = 1        --disable netrw plugins
        require("neo-tree").setup({
            close_if_last_window = true,    --close Neo-tree if last window
            popup_border_style = "rounded", --use rounded borders for popups
            enable_git_status = true,       --show git status
            enable_diagnostics = true,      --show LSP diagnostics
            event_handlers = {              --auto-close on file open
                {
                    event = "file_opened",
                    handler = function()
                        require("neo-tree.command").execute({action = "close"})
                    end
                }
            },
            default_component_configs = {
                indent = {                      --set indent size and padding
                    indent_size = 2,
                    padding = 1,
                },
                name = {                        --color names based on git status
                    use_git_status_colors = true
                }
            },
            window = {
                position = "left",                  --left, right, top, bottom, float, current
                width = 50,                         --set window width
                mappings = {
                    --fuzzy search
                    ["#"]               = {"fuzzy_sorter",              desc = "sort nodes using fuzzy matching"},
                    ["/"]               = {"fuzzy_finder",              desc = "find nodes using fuzzy matching"},
                    ["<C-/>"]           = {"fuzzy_finder_directory",    desc = "find directories using fuzzy matching"},
                    ["D"]               = "none",

                    --file system
                    ["<"]               = {"prev_source",               desc = "switch to previous source"},
                    [">"]               = {"next_source",               desc = "switch to next source"},
                    ["<2-LeftMouse>"]   = "none",
                    ["u"]               = {"navigate_up",               desc = "go up one directory level"},
                    ["s"]               = {"set_root",                  desc = "set as root directory"},
                    ["."]               = "none",
                    ["<esc>"]           = {"cancel",                    desc = "close Neo-tree"},
                    ["q"]               = {"close_window",              desc = "close Neo-tree window"},
                    ["?"]               = {"show_help",                 desc = "show help"},
                    ["R"]               = {"refresh",                   desc = "refresh tree view"},
                    ["[g"]              = {"prev_git_modified",         desc = "jump to previous git change"},
                    ["]g"]              = {"next_git_modified",         desc = "jump to next git change"},
                    ["="]               = {"toggle_auto_expand_width",  desc = "toggle auto width"},
                    ["e"]               = "none",

                    --folder control
                    ["<space>"]         = {"toggle_node",               desc = "toggle folder open/close"},
                    ["o"]               = {"open",                      desc = "open file / toggle folder"},
                    ["O"]               = {"expand_all_subnodes",       desc = "expand all subfolders"},
                    ["c"]               = {"close_node",                desc = "close current folder"},
                    ["C"]               = {"close_all_subnodes",        desc = "close all subfolders"},
                    ["z"]               = "none",

                    --preview
                    ["<C-b>"]           = {"scroll_preview",            desc = "scroll preview down"},
                    ["<C-f>"]           = {"scroll_preview",            desc = "scroll preview up"},
                    ["P"]               = {"toggle_preview",            desc = "toggle file preview"},
                    ["p"]               = {"focus_preview",             desc = "focus preview window"},
                    ["l"]               = "none",

                    --open files
                    ["<cr>"]            = {"open",                      desc = "open file in current window"},
                    ["h"]               = {"open_split",                desc = "open in horizontal split"},
                    ["S"]               = "none",
                    ["v"]               = {"open_rightbelow_vs",        desc = "open in vertical split (right)"},
                    ["V"]               = {"open_leftabove_vs",         desc = "open in vertical split (left)"},
                    ["t"]               = {"open_tabnew",               desc = "open in new tab"},
                    ["w"]               = {"open_with_window_picker",   desc = "open with window picker"},

                    --file actions
                    ["a"]               = {"add",                       desc = "add file/folder"},
                    ["A"]               = {"add_directory",             desc = "add folder"},
                    ["<bs>"]            = {"delete",                    desc = "delete file/folder"},
                    ["<del>"]           = {"delete",                    desc = "delete file/folder"},
                    ["H"]               = {"toggle_hidden",             desc = "toggle hidden files"},
                    ["i"]               = {"show_file_details",         desc = "show file details"},
                    ["<C-x>"]           = {"cut_to_clipboard",          desc = "cut to clipboard"},
                    ["x"]               = "none",
                    ["<C-y>"]           = {"copy_to_clipboard",         desc = "copt to clipboard"},
                    ["y"]               = "none",
                    ["<C-p>"]           = {"paste_from_clipboard",      desc = "paste from clipboard"},
                    ["r"]               = {"rename",                    desc = "rename the current file"},
                    ["b"]               = {"rename_basename",           desc = "rename base name of the current file"},

                    --sorting
                    ["<leader>c"]       = {"order_by_created",          desc = "sort by created date"},
                    ["oc"]              = "none",
                    ["<leader>d"]       = {"order_by_diagnostics",      desc = "sort by diagnostics"},
                    ["od"]              = "none",
                    ["<leader>g"]       = {"order_by_git_status",       desc = "sort by git status"},
                    ["og"]              = "none",
                    ["<leader>m"]       = {"order_by_modified",         desc = "sort by modified date"},
                    ["om"]              = "none",
                    ["<leader>n"]       = {"order_by_name",             desc = "sort by name (default)"},
                    ["on"]              = "none",
                    ["<leader>s"]       = {"order_by_size",             desc = "sort by size"},
                    ["os"]              = "none",
                    ["<leader>t"]       = {"order_by_type",             desc = "sort by type"},
                    ["ot"]              = "none",

                    --filters
                    ["<leader>x"]       = {"clear_filter",              desc = "clear filter"},
                    ["<C-a>"]           = {"filter_on_submit",          desc = "apply filter"}
                }
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,                  --don't hide dot files
                    hide_gitignored = true,                 --hide git ignored files
                    hide_hidden = false,                    --don't hide hidden files for Microsoft Windows
                    hide_by_name = {
                        "node_modules",
                    },
                    hide_by_pattern = {
                        "*/.o",
                        "*/.exe",
                    },
                    always_show = {
                        ".env",
                    },
                    never_show = {
                    }
                },
                follow_current_file = {
                    enabled = true                          --focus current buffer
                },
                hijack_netrw_behavior   = "open_default",   --use Neo-tree instead of netrw
                use_libuv_file_watcher  = true              --auto-refresh on file changes
            },
            buffers = {
                follow_current_file = {
                    enabled = true,                         --focus current buffer
                },
                show_unloaded = true,                       --show unloaded buffers
                window = {
                    mappings = {
                        ["<CR>"]    = "open",               --open buffer
                        ["o"]       = "open",               --open buffer
                        ["d"]       = "buffer_delete",      --delete buffer
                        ["<BS>"]    = "buffer_delete",      --delete buffer
                        ["<Del>"]   = "buffer_delete",      --delete buffer
                        ["u"]       = "navigate_up",        --navigate up
                        ["s"]       = "set_root",           --set root
                        ["r"]       = "refresh",            --refresh buffer list
                        ["q"]       = "close_window",       --close window
                        ["<Esc>"]   = "close_window",       --close window
                    }
                }
            },
            git_status = {
                window = {
                    position = "float",                     --open git status in floating window
                    mappings = {
                        ["A"]   = {"git_add_all",           desc = "stage all modified files"},
                        ["a"]   = {"git_add_file",          desc = "stage the current file"},
                        ["ga"]  = "none",
                        ["u"]   = {"git_unstage_file",      desc = "unstage the current file"},
                        ["gu"]  = "none",
                        ["U"]   = {"git_undo_last_commit",  desc = "undo last commit"},
                        ["gU"]  = "none",
                        ["r"]   = {"git_revert_file",       desc = "revert changes in the current file"},
                        ["gr"]  = "none",
                        ["c"]   = {"git_commit",            desc = "commit staged changed to local repo"},
                        ["gc"]  = "none",
                        ["p"]   = {"git_push",              desc = "push all local commits to origin branch"},
                        ["gp"]  = "none",
                        ["C"]   = {"git_commit_and_push",   desc = "commit staged changes and push to origin branch"},
                        ["gg"]  = "none",
                    }
                }
            }
        })
        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("NeoTreeClose", {clear = true}),
            callback = function()
                local layout = vim.api.nvim_call_function("winlayout", {})
                if  layout [1] == "leaf" and
                    vim.bo [vim.api.nvim_win_get_buf(layout [2])].filetype == "neo-tree" and
                    layout [3] == nil
                then
                    vim.cmd("quit")                         --auto-close Neo-tree if last window
                end
            end,
        })
    end,
}
