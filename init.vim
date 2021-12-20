" vim:set expandtab shiftwidth=2 tabstop=8 textwidth=72:

call plug#begin()
    " gruvbox 插件
    Plug 'morhetz/gruvbox'
    
    " github-nvim-theme 插件
    Plug 'projekt0n/github-nvim-theme'

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

call plug#end()

set hidden
set history=500
filetype plugin indent on
set autoread
set laststatus=2
set noshowmode
au FocusGained,BufEnter * checktime

nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

let mapleader=";"
set scrolloff=1
set tags=./tags;,tags,/usr/local/etc/systags
set nobackup

set expandtab
set textwidth=120
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

set wildmenu
set ruler
set cmdheight=1
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set relativenumber
set nu
set clipboard+=unnamed

au BufNewFile,BufRead *.js, *.html, *.css 
      \ set tabstop=2 
      \ set softtabstop=2
      \ set shiftwidth=2
au BufRead, BufNewFile *.py, *.pyw, *.c, *.h match BadWhitespace /\s\+$/

set ruler

if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undodir
  if !isdirectory(&undodir)
    call mkdir(&undodir, 'p', 0700)
  endif
endif

if has('mouse')
  if has('gui_running') || (&term =~ 'xterm' && !has('mac'))
    set mouse=a
  else
    set mouse=nvi
  endif
endif
  
" 修改光标上下键一次移动一个屏幕行
nnoremap <Up>        gk
inoremap <Up>   <C-O>gk
nnoremap <Down>      gj
inoremap <Down> <C-O>gj

" 切换窗口的键映射
nnoremap <C-Tab>   <C-W>w
inoremap <C-Tab>   <C-O><C-W>w
nnoremap <C-S-Tab> <C-W>W
inoremap <C-S-Tab> <C-O><C-W>W

au BufRead,BufNewFile *.py set expandtab
au BufRead,BufNewFile *.go set expandtab

set completeopt=menu,menuone,noselect

lua require("common")

lua require('gopls')
lua require('pyright')
lua require('solargraph')
lua require('nvim-cmp')


" Nerdtree 设置
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swp', '\.git',]
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>r :NERDTreeRefreshRoot<CR>

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif


" Airline 设置
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#overflow_marker = '_'
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline_theme='gruvbox'

" vim-go 设置
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

let g:godef_split=2

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

