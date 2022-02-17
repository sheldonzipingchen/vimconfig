require("circles").setup({
    icons = {
        empty = "",
        filled = "",
        lsp_prefix = ""
    },
    lsp = true
})

local autopairs = require('nvim-autopairs')
autopairs.setup{}

require("nightfox").load('nightfox')

require('lualine').setup {
    options = {
        theme = "nightfox"
    }
}
