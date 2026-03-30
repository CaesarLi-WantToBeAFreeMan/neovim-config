return {
    "nvim-neo-tree/neo-tree.nvim", --modern file explorer
    branch = "v3.x", --use stable v3.x branch
    cmd = "Neotree",
    dependencies = {
        "nvim-lua/plenary.nvim", --lua utility library for Neovim
        "nvim-tree/nvim-web-devicons", --file icons
        "MunifTanjim/nui.nvim", --ui components
    },
    keys = {
        { "<F1>", "<cmd>Neotree toggle filesystem<CR>", mode = "n", desc = "toggle file explorer" },
        { "<S-F1>", "<cmd>Neotree toggle git_status<CR>", mode = "n", desc = "toggle git status" },
        { "<C-F1>", "<cmd>Neotree toggle buffers<CR>", mode = "n", desc = "toggle buffer list" },
    },
    opts = {
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = false,

        --auto close when a file is opened
        event_handlers = {
            {
                event = "file_opened",
                handler = function() require("neo-tree.command").execute({ action = "close" }) end,
            },
        },

        --custom commands
        commands = {
            toggle_node_recursively = function(state)
                local node = state.tree:get_node()
                if not node then return end
                if node:is_expanded() then
                    state.commands.close_all_subnodes(state, node)
                else
                    state.commands.expand_all_subnodes(state, node)
                end
                require("neo-tree.ui.renderer").redraw(state)
            end,
        },

        --icons
        default_component_configs = {
            container = { enable_character_fade = true },
            icon = {
                default = "",
                folder_closed = "󰉋",
                folder_open = "󰝰",
                folder_empty = "󰉖",
                folder_empty_open = "",
            },
            git_status = {
                symbols = {
                    added = "",
                    modified = "",
                    deleted = "",
                    renamed = "",
                    untracked = "󰡯",
                    ignored = "",
                    unstaged = "󱪡",
                    staged = "󰝒",
                    conflict = "󰩋",
                },
            },
            indent = { --set indent size and padding
                indent_size = 2,
                padding = 1,
                with_markers = true,
                indent_marker = "┝",
                last_indent_marker = "┗",
                with_expanders = true,
                expander_collapsed = "▶",
                expander_expanded = "▼",
            },
        },
        --shared window key mappings
        window = {
            width = 50, --set window width
            mapping_options = {
                noremap = true,
                nowait = true,
            },
            mappings = {
                --close
                ["q"] = { "close_window", desc = "close Neo-tree" },
                ["<esc>"] = { "close_window", desc = "close Neo-tree" },

                --navigation
                ["<space>"] = { "toggle_node", desc = "toggle folder" },
                ["<cr>"] = { "open", desc = "open file / toggle folder" },
                ["o"] = { "open", desc = "open node" },
                ["zo"] = { "open", desc = "open node" },
                ["O"] = { "expand_all_subnodes", desc = "open node recursively" },
                ["zO"] = { "expand_all_subnodes", desc = "open node recursively" },
                ["c"] = { "close_node", desc = "close node" },
                ["zc"] = { "close_node", desc = "close node" },
                ["C"] = { "close_all_subnodes", desc = "close node recursively" },
                ["zC"] = { "close_all_subnodes", desc = "close node recursively" },
                ["x"] = { "toggle_node", desc = "toggle node" },
                ["za"] = { "toggle_node", desc = "toggle node" },
                ["X"] = { "toggle_node_recursively", desc = "toggle node recursively" },
                ["zA"] = { "toggle_node_recursively", desc = "toggle node recursively" },

                --open in split/tab
                ["h"] = { "open_split", desc = "open in horizontal split" },
                ["v"] = { "open_vsplit", desc = "open in vertical split" },
                ["t"] = { "open_tabnew", desc = "open in new tab" },
                ["w"] = { "open_with_window_picker", desc = "open with window picker" },

                --file actions
                ["r"] = { "rename", desc = "rename filename" },
                ["R"] = { "rename_basename", desc = "rename extension" },
                ["<C-x>"] = { "cut_to_clipboard", desc = "cut to clipboard" },
                ["<C-y>"] = { "copy_to_clipboard", desc = "copy to clipboard" },
                ["<C-p>"] = { "paste_from_clipboard", desc = "paste from clipboard" },
                ["<C-c>"] = { "clear_clipboard", desc = "clear clipboard" },
                ["<C-r>"] = { "refresh", desc = "refresh tree view" },

                --preview
                ["p"] = { "toggle_preview", desc = "toggle file preview" },

                --info & help
                ["?"] = { "show_help", desc = "show help" },
                ["<leader>i"] = { "show_file_details", desc = "show details" },

                --sorting
                ["<leader>c"] = { "order_by_created", desc = "sort by created date" },
                ["<leader>d"] = { "order_by_diagnostics", desc = "sort by diagnostics" },
                ["<leader>g"] = { "order_by_git_status", desc = "sort by git status" },
                ["<leader>m"] = { "order_by_modified", desc = "sort by modified date" },
                ["<leader>n"] = { "order_by_name", desc = "sort by name" },
                ["<leader>s"] = { "order_by_size", desc = "sort by size" },
                ["<leader>t"] = { "order_by_type", desc = "sort by type" },

                --disabled default key mappings
                ["<"] = "none",
                [">"] = "none",
                ["<2-LeftMouse>"] = "none",
                ["z"] = "none",
                ["S"] = "none",
                ["s"] = "none",
                ["b"] = "none",
                ["y"] = "none",
                ["P"] = "none",
                ["l"] = "none",
                ["e"] = "none",
                ["i"] = "none",
                ["oc"] = "none",
                ["od"] = "none",
                ["og"] = "none",
                ["om"] = "none",
                ["on"] = "none",
                ["os"] = "none",
                ["ot"] = "none",
            },
        },
        --file system source
        filesystem = {
            follow_current_file = {
                enabled = true, --focus current buffer
            },
            hijack_netrw_behavior = "open_default", --use Neo-tree instead of netrw
            use_libuv_file_watcher = true, --auto-refresh on file changes
            use_default_mappings = false, --disable all default keymaps
            filtered_items = {
                hide_dotfiles = false, --don't hide dot files
                hide_gitignored = true, --hide git ignored files
                hide_hidden = false, --don't hide hidden files for Microsoft Windows
                hide_by_name = {
                    "node_modules",
                    ".idea",
                    ".vscode",
                    "dist",
                },
                hide_by_pattern = {
                    "*.o",
                    "*.exe",
                    "*.class",
                },
            },
            window = {
                position = "left",
                mappings = {
                    --search
                    ["#"] = { "fuzzy_sorter", desc = "fuzzy sort" },
                    ["/"] = { "fuzzy_finder", desc = "fuzzy find" },
                    ["<C-/>"] = { "fuzzy_finder_directory", desc = "fuzzy find directory" },

                    --navigation
                    ["u"] = { "navigate_up", desc = "go up one directory level" },
                    ["s"] = { "set_root", desc = "set as root directory" },
                    ["[g"] = { "prev_git_modified", desc = "previous git change" },
                    ["]g"] = { "next_git_modified", desc = "next git change" },

                    --file actions
                    ["a"] = { "add", desc = "add file/folder" },
                    ["A"] = { "add_directory", desc = "add folder" },
                    ["m"] = { "move", desc = "move" },
                    ["d"] = { "delete", desc = "delete" },
                    ["<bs>"] = { "delete", desc = "delete" },
                    ["<del>"] = { "delete", desc = "delete" },

                    --toggles
                    ["="] = {
                        function(_)
                            local win = vim.api.nvim_get_current_win()
                            local width = vim.api.nvim_win_get_width(win)
                            vim.api.nvim_win_set_width(win, width == 50 and math.floor(vim.o.columns) or 50)
                        end,
                        desc = "toggle full/50-column width",
                    },
                    ["<leader>h"] = { "toggle_hidden", desc = "toggle hidden files" },

                    --disabled default key mappings
                    ["D"] = "none",
                    ["."] = "none",
                    ["H"] = "none",
                },
            },
        },
        --buffer source
        buffers = {
            follow_current_file = {
                enabled = true, --focus current buffer
            },
            show_unloaded = true, --show unloaded buffers
            window = {
                position = "float", --open buffers in floating window
                mappings = {
                    ["d"] = { "buffer_delete", desc = "delete buffer" },
                    ["<BS>"] = { "buffer_delete", desc = "delete buffer" },
                    ["<Del>"] = { "buffer_delete", desc = "delete buffer" },
                    ["A"] = { "add_directory", desc = "add folder" },
                    ["s"] = { "set_root", desc = "set as root directory" },

                    --disabled default key mappings
                    ["bd"] = "none",
                    ["."] = "none",
                },
            },
        },
        --git status key mappings
        git_status = {
            window = {
                position = "float", --open git status in floating window
                mappings = {
                    ["a"] = { "git_add_file", desc = "stage file" },
                    ["A"] = { "git_add_all", desc = "stage all" },
                    ["u"] = { "git_unstage_file", desc = "unstage file" },
                    ["c"] = { "git_commit", desc = "commit" },
                    ["C"] = { "git_commit_and_push", desc = "commit & push" },
                    ["p"] = { "git_push", desc = "push" },
                    ["r"] = { "git_revert_file", desc = "revert file" },

                    --disabled default key mappings
                    ["ga"] = "none",
                    ["gu"] = "none",
                    ["gU"] = "none",
                    ["gc"] = "none",
                    ["gp"] = "none",
                    ["gg"] = "none",
                    ["gr"] = "none",
                },
            },
        },
    },
}
