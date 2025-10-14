--a modern file explorer
return{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",--lua utility library for Neovim
        "nvim-tree/nvim-web-devicons",--file icons
        "MunifTanjim/nui.nvim",--ui components
    },
    keys = {
        {
            "<F1>",
            "<cmd>Neotree toggle<CR>",
            desc = "toggle Neo-tree",
            mode = "n"
        },
        {
            "<F1>g",
            "<cmd>Neotree git_status<CR>",
            desc = "show git status in Neo-tree",
            mode = "n"
        },
        {
            "<F1>b",
            function()
                vim.cmd("Neotree close")--close Neo-tree first
                vim.defer_fn(
                    function()
                        vim.cmd("Neotree buffers")
                    end,
                    50--delay in ms
                )
            end,
            desc = "show buffers in Neo-tree",
            mode = "n"
        },
    },
    config = function()
        --disable vim's default file explorer netrw
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("neo-tree").setup({
            close_if_last_window = true,--close Neo-tree if it's last window
            popup_border_style = "rounded",--border styele
            enable_git_status = true,--show git status
            enable_diagnostics = true,--show LSP diagnostics

            --functions to handle events
            event_handlers = {
                --auto-close Neo-tree when opening a file
                {
                    event = "file_opened",
                    handler = function()
                        require("neo-tree.command").execute({action = "close"})
                    end,
                },
            },

            --sort files
            sort_case_insensitive = false,--case sensitive sort
            sort_function = nil,--use default sorting function

            --[[
                +-=================================-+
                | DEFAULT COMPONENT CONFIGURATION   |
                +-=================================-+
            ]]
            default_component_configs = {
                container = {
                    enable_character_fade = true,
                },
                indent = {
                    indent_size = 2,
                    padding = 1,
                },
                name = {
                    trailing_slash = false,--don't show trailing slash
                    use_git_status_colors = true
                },
            },

            --[[
                +-=========-+
                | WINDOW    |
                +-=========-+
            ]]
            window = {
                position = "left",--left, right, top, bottom, float, current
                width = 50,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },

                mappings = {
                    --fuzzy search
                    ["#"] = {
                        "fuzzy_sorter",
                        desc = "sort nodes using fuzzy matching"
                    },
                    ["/"] = {
                        "fuzzy_finder",
                        desc = "find nodes using fuzzy matching"
                    },
                    ["<C-/>"] = {
                        "fuzzy_finder_directory",
                        desc = "find directories using fuzzy matching"
                    },
                    ["D"] = "none",

                    --file system
                    ["<"] = {
                        "prev_source",
                        desc = "switch to previous source"
                    },
                    [">"] = {
                        "next_source",
                        desc = "switch to next source"
                    },
                    ["<2-LeftMouse>"] = "none",
                    ["u"] = {
                        "navigate_up",
                        desc = "go up one directory level"
                    },
                    ["s"] = {
                        "set_root",
                        desc = "set as root directory"
                    },
                    ["."] = "none",
                    ["<esc>"] = {
                        "cancel",
                        desc = "close Neo-tree"
                    },
                    ["q"] = {
                        "close_window",
                        desc = "close Neo-tree window"
                    },
                    ["?"] = {
                        "show_help",
                        desc = "show help"
                    },
                    ["R"] = {
                        "refresh",
                        desc = "refresh tree view"
                    },
                    ["[g"] = {
                        "prev_git_modified",
                        desc = "jump to previous git change"
                    },
                    ["]g"] = {
                        "next_git_modified",
                        desc = "jump to next git change"
                    },
                    ["="] = {
                        "toggle_auto_expand_width",
                        desc = "toggle auto width"
                    },
                    ["e"] = "none",

                    --folder control
                    ["<space>"] = {
                        "toggle_node",
                        desc = "toggle folder open/close"
                    },
                    ["o"] = {
                        "open",
                        desc = "open file / toggle folder"
                    },
                    ["O"] = {
                        "expand_all_subnodes",
                        desc = "expand all subfolders"
                    },
                    ["c"] = {
                        "close_node",
                        desc = "close current folder"
                    },
                    ["C"] = {
                        "close_all_subnodes",
                        desc = "close all subfolders"
                    },
                    ["z"] = "none",

                    --preview
                    ["<C-b>"] = {
                        "scroll_preview",
                        desc = "scroll preview down"
                    },
                    ["<C-f>"] = {
                        "scroll_preview",
                        desc = "scroll preview up"
                    },
                    ["P"] = {
                        "toggle_preview",
                        desc = "toggle file preview"
                    },
                    ["p"] = {
                        "focus_preview",
                        desc = "focus preview window"
                    },
                    ["l"] = "none",

                    --open files
                    ["<cr>"] = {
                        "open",
                        desc = "open file in current window"
                    },
                    ["h"] = {
                        "open_split",
                        desc = "open in horizontal split"
                    },
                    ["S"] = "none",
                    ["v"] = {
                        "open_rightbelow_vs",
                        desc = "open in vertical split (right)"
                    },
                    ["V"] = {
                        "open_leftabove_vs",
                        desc = "open in vertical split (left)"
                    },
                    ["s"] = "none",
                    ["t"] = {
                        "open_tabnew",
                        desc = "open in new tab"
                    },
                    ["w"] = {
                        "open_with_window_picker",
                        desc = "open with window picker"
                    },

                    --file actions
                    ["a"] = {
                        "add",
                        desc = "add file/folder"
                    },
                    ["A"] = {
                        "add_directory",
                        desc = "add folder"
                    },
                    ["<bs>"] = {
                        "delete",
                        desc = "delete file/folder"
                    },
                    ["<del>"] = {
                        "delete",
                        desc = "delete file/folder"
                    },
                    ["H"] = {
                        "toggle_hidden",
                        desc = "toggle hidden files"
                    },
                    ["i"] = {
                        "show_file_details",
                        desc = "show file details"
                    },
                    ["<C-x>"] = {
                        "cut_to_clipboard",
                        desc = "cut to clipboard"
                    },
                    ["x"] = "none",
                    ["<C-y>"] = {
                        "copy_to_clipboard",
                        desc = "copt to clipboard"
                    },
                    ["y"] = "none",
                    ["<C-p>"] = {
                        "paste_from_clipboard",
                        desc = "paste from clipboard"
                    },
                    ["r"] = {
                        "rename",
                        desc = "rename the current file"
                    },
                    ["b"] = {
                        "rename_basename",
                        desc = "rename base name of the current file"
                    },

                    --sorting
                    ["<leader>c"] = {
                        "order_by_created",
                        desc = "sort by created date"
                    },
                    ["oc"] = "none",
                    ["<leader>d"] = {
                        "order_by_diagnostics",
                        desc = "sort by diagnostics"
                    },
                    ["od"] = "none",
                    ["<leader>g"] = {
                        "order_by_git_status",
                        desc = "sort by git status"
                    },
                    ["og"] = "none",
                    ["<leader>m"] = {
                        "order_by_modified",
                        desc = "sort by modified date"
                    },
                    ["om"] = "none",
                    ["<leader>n"] = {
                        "order_by_name",
                        desc = "sort by name (default)"
                    },
                    ["on"] = "none",
                    ["<leader>s"] = {
                        "order_by_size",
                        desc = "sort by size"
                    },
                    ["os"] = "none",
                    ["<leader>t"] = {
                        "order_by_type",
                        desc = "sort by type"
                    },
                    ["ot"] = "none",

                    --filters
                    ["<leader>x"] = {
                        "clear_filter",
                        desc = "clear filter"
                    },
                    ["<C-x>"] = "none",
                    ["<C-a>"] = {
                        "filter_on_submit",
                        desc = "apply filter"
                    },
                },
            },

            --[[
                +-=============-+
                | FILE SYSTEM   |
                +-=============-+
            ]]
            filesystem = {
                filtered_items = {
                    visible = false,--show filtered items with dimmed text
                    hide_dotfiles = false,--don't hide dot files
                    hide_gitignored = true,--hide git ignored files
                    hide_hidden = false,--don't hide hidden files for Microsoft Windows
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
                    },
                },
                follow_current_file = {
                    enabled = true,--find and focus current file
                    leave_dirs_open = false,--don't leave directories open
                },
                group_empty_dirs = false,--don't group empty directories
                hijack_netrw_behavior = "open_default",--use Neo-tree instead of netrw
                use_libuv_file_watcher = true,--auto-refresh on file changes
            },

            --[[
                +-=========-+
                | BUFFERS   |
                +-=========-+
            ]]

            buffers = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                group_empty_dirs = true,
                show_unloaded = true,
                window = {
                    mappings = {
                        ["<CR>"] = "open",
                        ["o"] = "open",
                        ["d"] = "buffer_delete",
                        ["<BS>"] = "buffer_delete",
                        ["<Del>"] = "buffer_delete",
                        ["u"] = "navigate_up",
                        ["s"] = "set_root",
                        ["r"] = "refresh",
                        ["q"] = "close_window",
                        ["<Esc>"] = "close_window",
                    },
                },
            },

            --[[
                +-=============-+
                | GIT STATUS    |
                +-=============-+
            ]]

            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["A"] = {
                            "git_add_all",
                            desc = "stage all modified files"
                        },
                        ["a"] = {
                            "git_add_file",
                            desc = "stage the current file"
                        },
                        ["ga"] = "none",
                        ["u"] = {
                            "git_unstage_file",
                            desc = "unstage the current file"
                        },
                        ["gu"] = "none",
                        ["U"] = {
                            "git_undo_last_commit",
                            desc = "undo last commit"
                        },
                        ["gU"] = "none",
                        ["r"] = {
                            "git_revert_file",
                            desc = "revert changes in the current file"
                        },
                        ["gr"] = "none",
                        ["c"] = {
                            "git_commit",
                            desc = "commit staged changed to local repo"
                        },
                        ["gc"] = "none",
                        ["p"] = {
                            "git_push",
                            desc = "push all local commits to origin branch"
                        },
                        ["gp"] = "none",
                        ["C"] = {
                            "git_commit_and_push",
                            desc = "commit staged changes and push to origin branch"
                        },
                        ["gg"] = "none",
                    },
                },
            },
        })

        --auto-close Neo-tree when opening a file
        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("NeoTreeClose", {clear = true}),
            callback = function()
                local layout = vim.api.nvim_call_function("winlayout", {})
                if  layout [1] == "leaf" and
                    vim.bo [vim.api.nvim_win_get_buf(layout [2])].filetype == "neo-tree" and
                    layout [3] == nil
                then
                    vim.cmd("quit")
                end
            end,
        })
    end,
}
