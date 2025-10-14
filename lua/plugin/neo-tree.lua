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
                    --file system
                    ["u"] = "navigate_up",--move root up a directory level
                    ["<BS>"] = "none",
                    ["s"] = "set_root",--set current directory as root
                    ["."] = "none",

                    --folders
                    ["<space>"] = "toggle_node",--open/close folders
                    --open/close all sub-nodes under the folder
                    ["o"] = "expand_node",--open folders
                    ["O"] = "expand_all_subnodes",--open all sub-nodes under the folder
                    ["c"] = "close_node",--close folders
                    ["C"] = "close_all_subnodes",--close all sub-nodes under the folder
                    ["z"] = "none",

                    --preview
                    ["e"] = "toggle_preview",--like P
                    ["p"] = "focus_preview",--like l
                    ["<C-u>"] = "scroll_preview_up",--like <C-b>
                    ["<C-d>"] = "scroll_preview_down",--like <C-f>

                    --open files
                    ["h"] = "open_split",--open in a new horizontal split
                    ["S"] = "none",
                    ["v"] = "open_rightbelow_vs",--open in a vertical split at right side
                    ["V"] = "open_leftabove_vs",--open in a vertical split at left side
                    ["s"] = "none",

                    --files
                    ["<BS>"] = "delete",--delete a file/folder
                    ["<Del>"] = "delete",--delete a file/folder

                    --order by
                    ["<leader>?"] = "order_by...",--show help menu for order by choices
                    ["<leader>c"] = "order_by_created",--sort by created date
                    ["<leader>d"] = "order_by_diagnostics",--sort by diagnostic severity
                    ["<leader>g"] = "order_by_git_status",--sort by git status
                    ["<leader>m"] = "order_by_modified",--sort by modified date
                    ["<leader>n"] = "order_by_name",--sort by name(default)
                    ["<leader>s"] = "order_by_size",--sort by size
                    ["<leader>t"] = "order_by_type",--sort by type
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
                        ["A"] = "git_add_all",--stage all
                        ["a"] = "git_add_file",--stage current file
                        ["u"] = "git_unstage_file",--unstage current file
                        ["r"] = "git_revert_file",--revert current file
                        ["c"] = "git_commit",--commit
                        ["p"] = "git_push",--push
                        ["C"] = "git_commit_and_push",--commit and push
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
