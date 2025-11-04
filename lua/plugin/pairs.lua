return{
    --auto-pair brackets/quotes
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true
        },
    },
    --auto-close/rename HTML/XML tags
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {}
    },
    --surround manipulations
    {
        "echasnovski/mini.surround",
        version = false,
    }
}
