return{
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {
        "nvim-telescope/telescope.nvim"
    },
    opts = {
        --root_dir is vim.fn.stdpath("data") .. "/sessions"
        purge_after_minutes = 21600,                --delete session after 15 days

        --disable auto restore (load) using dashboard
        auto_restore = false,
        auto_restore_last_session = false,

        session_lens = {
            picker = "telescope"
        },
        mappings = {
            delete_session = {"n", "<leader>sd"},           --delete session
            alternate_session = {"n", "<leader>sa"},        --alternate (swap) sessions
            copy_session = {"n", "<leader>sc"}              --copy session
        }
    },
    config = function()
        local set = function(mode, key, action, desc)
            vim.keymap.set(mode, key, action, { silent = true, nowait = true, desc = desc })
        end

        set("n", "<leader>ss", "<cmd>AutoSeession search<CR>", "seearch sessions")
        set("n", "<leader>sw", "<cmd>AutoSession save<CR>", "save session")
        set("n", "<leader>sr", "<cmd>AutoSession restore<CR>", "restore session")
    end
}
