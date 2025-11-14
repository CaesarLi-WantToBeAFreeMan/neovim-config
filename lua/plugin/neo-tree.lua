return{
    {
        "nvim-neo-tree/neo-tree.nvim",      --modern file explorer
        event = "VeryLazy",
        branch = "v3.x",                    --use stable v3.x branch
        dependencies = {
            "nvim-lua/plenary.nvim",        --lua utility library for Neovim
            "nvim-tree/nvim-web-devicons",  --file icons
            "MunifTanjim/nui.nvim"          --ui components
        },
        keys = {
            {"<F1>",    "<cmd>Neotree toggle filesystem<CR>",   desc = "toggle Neo-tree",   mode = "n"},
            {"<S-F1>",  "<cmd>Neotree toggle git_status<CR>",   desc = "toggle git status", mode = "n"},
            {"<C-F1>",  "<cmd>Neotree toggle buffers<CR>",      desc = "toggle buffers",    mode = "n"},
        },
        opts = {
            --file explorer, buffer explorer, git status explorer, symbol explorer
            close_if_last_window = true,    --close Neo-tree if last window
            popup_border_style = "rounded", --use rounded borders for popups
            enable_git_status = true,       --show git status
            enable_diagnostics = false,     --hide LSP diagnostic icons
            event_handlers = {              --auto-close on file open
                --auto close when file opened
                {
                    event = "file_opened",
                    handler = function()
                        require("neo-tree.command").execute({action = "close"})
                    end
                }
            },
           commands = {
                toggle_node_recursively = function(state)
                    local node = state.tree:get_node()
                    if not node then
                        return
                    end

                    if node:is_expanded() then
                        state.commands.close_all_subnodes(state, node)
                    else
                        state.commands.expand_all_subnodes(state, node)
                    end
                    require("neo-tree.ui.renderer").redraw(state)
                end
            },
            default_component_configs = {
                container = {
                    enable_character_fade = true
                },
                icon = {
                    default = "",
                    folder_closed       = "󰉋",
                    folder_open         = "󰝰",
                    folder_empty        = "󰉖",
                    folder_empty_open   = ""
                },
                git_status = {
                    symbols = {
                        added           = "",
                        modified        = "",
                        deleted         = "",
                        renamed         = "",
                        untracked       = "󰡯",
                        ignored         = "",
                        unstaged        = "󱪡",
                        staged          = "󰝒",
                        conflict        = "󰩋"
                    }
                },
                indent = {                      --set indent size and padding
                    indent_size = 2,
                    padding = 1,
                    with_markers = true,
                    indent_marker = "┝",
                    last_indent_marker = "┗",
                    with_expanders = true,
                    expander_collapsed = "▶",
                    expander_expanded = "▼"
                },
            },
            window = {
                width = 50,                         --set window width
                mapping_options = {
                    noremap = true,
                    nowait = true
                },
                mappings = {
                    --close
                    ["q"]               = {"close_window",              desc = "close Neo-tree"},
                    ["<esc>"]           = {"close_window",              desc = "close Neo-tree"},

                    --folder control
                    ["<"]               = "none",
                    [">"]               = "none",
                    ["<space>"]         = {"toggle_node",               desc = "toggle folder"},
                    ["<cr>"]            = {"open",                      desc = "open file / toggle folder"},
                    ["<2-LeftMouse>"]   = "none",
                    ["o"]               = {"open",                      desc = "open node"},
                    ["zo"]              = {"open",                      desc = "open node"},
                    ["O"]               = {"expand_all_subnodes",       desc = "open node recursively"},
                    ["zO"]              = {"expand_all_subnodes",       desc = "open node recursively"},
                    ["c"]               = {"close_node",                desc = "close node"},
                    ["zc"]              = {"close_node",                desc = "close node"},
                    ["C"]               = {"close_all_subnodes",        desc = "close node recursively"},
                    ["zC"]              = {"close_all_subnodes",        desc = "close node recursively"},
                    ["x"]               = {"toggle_node",               desc = "toggle node"},
                    ["za"]              = {"toggle_node",               desc = "toggle node"},
                    ["X"]               = {"toggle_node_recursively",   desc = "toggle node recursively"},
                    ["zA"]              = {"toggle_node_recursively",   desc = "toggle node recursively"},
                    ["z"]               = "none",

                    --file actions
                    ["r"]               = {"rename",                    desc = "rename filename"},
                    ["R"]               = {"rename_basename",           desc = "rename extension"},
                    ["b"]               = "none",
                    ["<C-x>"]           = {"cut_to_clipboard",          desc = "cut to clipboard"},
                    ["<C-y>"]           = {"copy_to_clipboard",         desc = "copy to clipboard"},
                    ["y"]               = "none",
                    ["<C-p>"]           = {"paste_from_clipboard",      desc = "paste from clipboard"},
                    ["<C-c>"]           = {"clear_clipboard",           desc = "clear clipboard"},
                    ["?"]               = {"show_help",                 desc = "show help"},
                    ["<C-r>"]           = {"refresh",                   desc = "refresh tree view"},

                    --preview
                    ["p"]               = {"toggle_preview",            desc = "toggle file preview"},
                    ["P"]               = "none",
                    ["l"]               = "none",

                    --open files
                    ["h"]               = {"open_split",                desc = "open in horizontal split"},
                    ["S"]               = "none",
                    ["v"]               = {"open_vsplit",               desc = "open in vertical split"},
                    ["s"]               = "none",
                    ["t"]               = {"open_tabnew",               desc = "open in new tab"},
                    ["w"]               = {"open_with_window_picker",   desc = "open with window picker"},

                    --toggles
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
                    ["e"]               = "none",
                    ["<leader>i"]       = {"show_file_details",         desc = "show details"},
                    ["i"]               = "none",

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
                use_default_mappings = false,               --disable all default keymaps
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
                },
                window = {
                    position = "left",
                    mappings = {
                        --fuzzy search
                        ["#"]               = {"fuzzy_sorter",              desc = "sort nodes using fuzzy matching"},
                        ["/"]               = {"fuzzy_finder",              desc = "find nodes using fuzzy matching"},
                        ["<C-/>"]           = {"fuzzy_finder_directory",    desc = "find directories using fuzzy matching"},
                        ["D"]               = "none",

                        --file system
                        ["u"]               = {"navigate_up",               desc = "go up one directory level"},
                        ["s"]               = {"set_root",                  desc = "set as root directory"},
                        ["."]               = "none",
                        ["[g"]              = {"prev_git_modified",         desc = "jump to previous git change" },
                        ["]g"]              = {"next_git_modified",         desc = "jump to next git change" },

                        --file actions
                        ["a"]               = {"add",                       desc = "add file/folder"},
                        ["A"]               = {"add_directory",             desc = "add folder"},
                        ["m"]               = {"move",                      desc = "move node"},
                        ["d"]               = {"delete",                    desc = "delete node"},
                        ["<bs>"]            = {"delete",                    desc = "delete node"},
                        ["<del>"]           = {"delete",                    desc = "delete node"},

                        --toggles
                        ["="]               = {
                            function(_)
                                local win = vim.api.nvim_get_current_win()
                                local width = vim.api.nvim_win_get_width(win)
                                local new_width = (width == 50) and math.floor(vim.o.columns) or 50
                                vim.api.nvim_win_set_width(win, new_width)
                            end,
                            desc = "toggle 100% / 50 columns width"
                        },
                        ["<leader>h"]       = {"toggle_hidden",             desc = "toggle hidden files"},
                        ["H"]               = "none",
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
                        ["bd"]      = "none",
                        ["A"]       = {"add_directory",     desc = "add folder"},
                        ["s"]       = {"set_root",          desc = "set as root directory"},
                        ["."]       = "none"
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
                }
            }
        }
    },
    {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        event = "VeryLazy",
        config = function()
            require("window-picker").setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    bo = {
                        filetype = {"neo-tree", "neo-tree-popup", "notify"},
                        buftype = {"terminal", "quickfix"}
                    }
                }
            })
        end
    }
}
