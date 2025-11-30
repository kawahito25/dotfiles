return {
    "keaising/im-select.nvim",
    event = "InsertEnter",
    config = function()
        require("im_select").setup({
            default_im_select = 'com.google.inputmethod.Japanese.Roman'
        })
    end,
}
