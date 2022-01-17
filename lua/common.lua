require("circles").setup()

local autopairs = require('nvim-autopairs')
autopairs.setup{}

require("nightfox").load('nightfox')

require('lualine').setup {
    options = {
        theme = "nightfox"
    }
}
