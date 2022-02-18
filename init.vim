" vim:set expandtab shiftwidth=2 tabstop=8 textwidth=72:

call plug#begin()
    " nightfox 插件
    Plug 'EdenEast/nightfox.nvim'

    " minimalist 插件
    Plug 'dikiaap/minimalist'

    " nvim-lualine/lualine.nvim
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'

    " Nerdtree 插件
    Plug 'preservim/nerdtree'

    " vim-fugitive 插件
    Plug 'tpope/vim-fugitive'
    
    " Airline 插件
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " circles.nvim 插件
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'projekt0n/circles.nvim'

    " telescope.nvim 插件
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " nvim-lspconfig 插件
    Plug 'neovim/nvim-lspconfig'

    " nvim-cmp 插件
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " vsnip 插件
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

    " nvim-autopairs 插件
    Plug 'windwp/nvim-autopairs'

    " Golang 插件
    Plug 'fatih/vim-go', {'tag': '*'}

    " vimtex 插件
    Plug 'lervag/vimtex'

    " tex snippets 插件
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " javascript or typescript
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
    Plug 'jparise/vim-graphql'

call plug#end()

function! Dot(path)
  return "~/.config/nvim/" .a:path
endfunction

for file in split(glob(Dot('rc/*.vim')), '\n')
  exe 'source' file
endfor

lua << EOF

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

local nvim_lsp = require('lspconfig')

-- python lsp 配置
nvim_lsp.pyright.setup{}

-- rust lsp 配置
nvim_lsp.rust_analyzer.setup{}

EOF

lua require('nvim-cmp')


" vimtex 设置
let g:tex_flavor = 'xelatex'

let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_quickfix_mode = 0

augroup vimtex_mac
    autocmd!
    autocmd User VimtexEventCompileSuccess call UpdateSkim()
augroup END

function! UpdateSkim() abort
    let l:out = b:vimtex.out()
    let l:src_file_path = expand('%:p')
    let l:cmd = [g:vimtex_view_general_viewer, '-r']

    if !empty(system('pgrep Skim'))
    call extend(l:cmd, ['-g'])
    endif

    call jobstart(l:cmd + [line('.'), l:out, l:src_file_path])
endfunction

" telescope 设置
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
