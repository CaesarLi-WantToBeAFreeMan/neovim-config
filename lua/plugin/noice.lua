return{
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
        "hrsh7th/nvim-cmp"
    },
    opts = {
        lsp = {
            override = {
                ["vim.lsu.util.convert_input_to_markdown_lines"] = true,    --format LSP hover and signature docs into markdown
                ["vim.lsp.util.stylize_markdown"] = true,                   --apply styling to LSP markdown popups
                ["cmp.entry.get_documentation"] = true                      --integrate completion documentation display
            }
        },
        messages = {
            timeout = 5000
        },
        presets = {
            bottom_search = true,                                           --move search bar to the bottom
            command_palette = true,                                         --enable command palette style popup for command mode
            lsp_doc_border = true                                           --add borders around LSP documentation windows
        }
    }
}
