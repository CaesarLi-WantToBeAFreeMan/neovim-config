return{
    "nvim-neo-tree/neo-tree.nvim",      --modern file explorer
    branch = "v3.x",                    --use stable v3.x branch
    dependencies = {
        "nvim-lua/plenary.nvim",        --lua utility library for Neovim
        "nvim-tree/nvim-web-devicons",  --file icons
        "MunifTanjim/nui.nvim"          --ui components
    },
    keys = {
        {"<F1>",    "<cmd>Neotree toggle filesystem<CR>",       desc = "toggle Neo-tree",           mode = "n"},
        {"<S-F1>",  "<cmd>Neotree toggle git_status<CR>",       desc = "toggle git status",         mode = "n"},
        {"<C-F1>",  "<cmd>Neotree toggle buffers<CR>",          desc = "toggle buffers",            mode = "n"},
    },
    config = function()
        vim.g.loaded_netrw = 1              --disable netrw
        vim.g.loaded_netrwPlugin = 1        --disable netrw plugins

        require("neo-tree").setup({
            --file explorer, buffer explorer, git status explorer, symbol explorer
            close_if_last_window = true,    --close Neo-tree if last window
            popup_border_style = "rounded", --use rounded borders for popups
            enable_git_status = true,       --show git status
            enable_diagnostics = false,     --hide LSP diagnostic icons
            event_handlers = {              --auto-close on file open
                --auto close after selecting a node
                {
                    event = "file_opened",
                    handler = function()
                        require("neo-tree.command").execute({action = "close"})
                    end
                }
            },
            default_component_configs = {
                icon = {
                    folder_closed   = "󰉋",
                    folder_open     = "󰝰",
                    folder_empty    = "󰉖"
                },
                git_status = {
                    symbols = {
                        added       = "",
                        modified    = "",
                        deleted     = "",
                        renamed     = "",
                        untracked   = "󰡯",
                        ignored     = "",
                        unstaged    = "󱪡",
                        staged      = "󰝒",
                        conflict    = "󰩋"
                    }
                },
                indent = {                      --set indent size and padding
                    indent_size = 2,
                    padding = 1
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
                    ["<"]               = "none",
                    [">"]               = "none",
                    ["<2-LeftMouse>"]   = "none",
                    ["u"]               = {"navigate_up",               desc = "go up one directory level"},
                    ["s"]               = {"set_root",                  desc = "set as root directory"},
                    ["."]               = "none",
                    ["<esc>"]           = {"close_window",              desc = "close Neo-tree"},
                    ["q"]               = {"close_window",              desc = "close Neo-tree"},
                    ["?"]               = {"show_help",                 desc = "show help"},
                    ["<C-r>"]           = {"refresh",                   desc = "refresh tree view"},
                    ["[g"]              = {"prev_git_modified",         desc = "jump to previous git change" },
                    ["]g"]              = {"next_git_modified",         desc = "jump to next git change" },
                    ["="]               = {"",                          desc = "toggle full width"},
                    ["e"]               = "none",

                    --navigation
                    ["K"]               = {"",                          desc = "go to first node"},
                    ["J"]               = {"",                          desc = "go to last node"},
                    ["<C-b>"]           = {"",                          desc = "scroll up 10 nodes"},
                    ["<C-f>"]           = {"",                          desc = "scroll down 10 nodes"},
                    ["<C-u>"]           = {"",                          desc = "scroll up 5 nodes"},
                    ["<C-d>"]           = {"",                          desc = "scroll down 5 nodes"},

                    --folder control
                    ["<space>"]         = {"toggle_node",               desc = "toggle folder"},
                    ["<cr>"]            = {"open",                      desc = "open file / toggle folder"},
                    ["o"]               = {"toggle_node",               desc = "open file / toggle folder"},
                    ["zo"]              = {"open",                      desc = "open file / toggle folder"},
                    ["O"]               = {"expand_all_subnodes",       desc = "open all folders recursively"},
                    ["zO"]              = {"expand_all_subnodes",       desc = "open all folders recursively"},
                    ["c"]               = {"close_node",                desc = "close folder"},
                    ["zc"]              = {"close_node",                desc = "close folder"},
                    ["C"]               = {"close_all_subnodes",        desc = "close all folders recursivel"},
                    ["zC"]              = {"close_all_subnodes",        desc = "close all folders recursively"},
                    ["z"]               = "none",

                    --preview
                    ["p"]               = {"toggle_preview",            desc = "toggle file preview"},
                    ["l"]               = "none",

                    --open files
                    ["h"]               = {"open_split",                desc = "open in horizontal split (below)"},
                    ["H"]               = {
                        function(state)
                            local node = state.tree:get_node()
                            if node and node.path then
                                vim.cmd("wincmd p")
                                vim.cmd("aboveleft split " .. vim.fn.fnameescape(node.path))
                                require("neo-tree.command").execute({action = "close"})
                            end
                        end,
                        desc = "open in horizontal split (above)"
                    },
                    ["S"]               = "none",
                    ["v"]               = {"open_vsplit",               desc = "open in vertical split (right)"},
                    ["V"]               = {
                        function(state)
                            local node = state.tree:get_node()
                            if node and node.path then
                                vim.cmd("wincmd p")
                                vim.cmd("leftabove vsplit " .. vim.fn.fnameescape(node.path))
                                require("neo-tree.command").execute({action = "close"})
                            end
                        end,
                        desc = "open in vertical split (left)"
                    },
                    ["t"]               = {"open_tabnew",               desc = "open in new tab"},
                    ["w"]               = {"open_with_window_picker",   desc = "open with window picker"},

                    --file actions
                    ["a"]               = {"add",                       desc = "add file/folder"},
                    ["A"]               = {"add_directory",             desc = "add folder"},
                    ["m"]               = {"move",                      desc = "move node"},
                    ["d"]               = {"delete",                    desc = "delete node"},
                    ["<bs>"]            = {"delete",                    desc = "delete node"},
                    ["<del>"]           = {"delete",                    desc = "delete node"},
                    ["<C-x>"]           = {"cut_to_clipboard",          desc = "cut to clipboard"},
                    ["x"]               = "none",
                    ["<C-y>"]           = {"copy_to_clipboard",         desc = "copy to clipboard"},
                    ["y"]               = "none",
                    ["<C-p>"]           = {"paste_from_clipboard",      desc = "paste from clipboard"},
                    ["r"]               = {"rename",                    desc = "rename filename"},
                    ["R"]               = {"rename_basename",           desc = "rename extension"},

                    --toggles
                    ["<leader>i"]       = {"show_file_details",         desc = "show details"},
                    ["i"]               = "none",
                    ["<leader>h"]       = {"toggle_hidden",             desc = "toggle hidden files"},
                    ["<leader>l"]       = {
                        function()
                            vim.wo.number = not vim.wo.number
                        end,
                        desc = "toggle numbers"
                    },
                    ["<leader>L"]       = {
                        function()
                            vim.wo.relativenumber = not vim.wo.relativenumber
                        end,
                        desc = "toggle relative numbers"
                    },

                    --sorting
                    ["<leader>c"]       = {"order_by_created",          desc = "sort by created date"},
                    ["oc"]              = "none",
                    ["<leader>d"]       = {"order_by_diagnostics",      desc = "sort by diagnostics"},
                    ["od"]              = "none",
                    ["<leader>g"]       = {"order_by_git_status",       desc = "sort by git status"},
                    ["og"]              = "none",
                    ["<leader>m"]       = {"order_by_modified",         desc = "sort by modified date"},
                    ["om"]              = "none",
                    ["<leader>n"]       = {"order_by_name",             desc = "sort by name"},
                    ["on"]              = "none",
                    ["<leader>s"]       = {"order_by_size",             desc = "sort by size"},
                    ["os"]              = "none",
                    ["<leader>t"]       = {"order_by_type",             desc = "sort by type"},
                    ["ot"]              = "none"
                }
            },
            filesystem = {
                follow_current_file = {
                    enabled = true                          --focus current buffer
                },
                hijack_netrw_behavior   = "open_default",   --use Neo-tree instead of netrw
                use_libuv_file_watcher  = true,             --auto-refresh on file changes
                filtered_items = {
                    hide_dotfiles = false,                  --don't hide dot files
                    hide_gitignored = true,                 --hide git ignored files
                    hide_hidden = false,                    --don't hide hidden files for Microsoft Windows
                    hide_by_name = {
                        "node_modules",
                        ".idea",
                        ".vscode"
                    },
                    hide_by_pattern = {
                        "*/.o",
                        "*/.exe",
                        "*/.class"
                    }
                }
            },
            buffers = {
                follow_current_file = {
                    enabled = true,                         --focus current buffer
                },
                show_unloaded = true,                       --show unloaded buffers
                window = {
                    position = "float",                     --open buffers in floating window
                    mappings = {
                        ["d"]       = {"buffer_delete",     desc = "delete current buffer"},
                        ["<BS>"]    = {"buffer_delete",     desc = "delete current buffer"},
                        ["<Del>"]   = {"buffer_delete",     desc = "delete current buffer"},
                        ["bd"]      = "none"
                    }
                }
            },
            git_status = {
                window = {
                    position = "float",                     --open git status in floating window
                    mappings = {
                        ["a"]   = {"git_add_file",          desc = "stage the current file"},
                        ["A"]   = {"git_add_all",           desc = "stage all modified files"},
                        ["ga"]  = "none",
                        ["u"]   = {"git_unstage_file",      desc = "unstage the current file"},
                        ["gu"]  = "none",
                        ["gU"]  = "none",
                        ["c"]   = {"git_commit",            desc = "commit staged changed to local repo"},
                        ["gc"]  = "none",
                        ["p"]   = {"git_push",              desc = "push all local commits to origin branch"},
                        ["gp"]  = "none",
                        ["C"]   = {"git_commit_and_push",   desc = "commit staged changes and push to origin branch"},
                        ["gg"]  = "none",
                        ["r"]   = {"git_revert_file",       desc = "revert file"},
                        ["gr"]  = "none"
                    }
                },
            }
        })

        --auto-close if Neo-tree is last window
        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("NeoTreeAutoClose", {clear = true}),
            callback = function()
                local layout = vim.fn.winlayout()
                if layout[1] == "leaf"
                    and vim.bo [vim.api.nvim_win_get_buf(layout[2])].filetype == "neo-tree"
                    and not layout[3]
                then
                    vim.cmd("quit")                         --auto-close Neo-tree if last window
                end
            end
        })
    end
}
