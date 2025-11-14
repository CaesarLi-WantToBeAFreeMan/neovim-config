return{
    "rmagatti/auto-session",
    event = "VeryLazy",
    dependencies = {
        "nvim-telescope/telescope.nvim"
    },
    opts = {
        purge_after_minutes = 21600,                --delete session after 15 days
        root_dir = vim.fn.stdpath("data") .. "/sessions",

        --disable auto restore (load) using dashboard
        auto_restore = false,
        auto_restore_last_session = false,

        session_lens = {
            picker = "telescope",
            preview = "summary",

            mappings = {
                delete_session =        {"i", "<C-d>"},     --delete
                alternate_session =     {"i", "<C-s>"},     --swap
                copy_session =          {"i", "<C-y>"}      --copy
            },

            picker_opts = {
                prompt_title = "Sessions",
                layout_strategy = "horizontal",
                layout_config = {width = 0.9, height = 0.8}
            }
        }
    }
}
