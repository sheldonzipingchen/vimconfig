call plug#begin()
    " 配色
    Plug 'morhetz/gruvbox'
    Plug 'jnurmine/Zenburn'

    " 目录管理插件
    Plug 'preservim/nerdtree'

    " lsp 插件
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " golang 插件
    Plug 'fatih/vim-go'

    " vim-beancount 插件
    Plug 'nathangrigg/vim-beancount'

    " vim-airline插件
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " ctrlp 插件
    Plug 'ctrlpvim/ctrlp.vim'

    " tagbar 插件
    Plug 'preservim/tagbar'

    " vim-gitgutter 插件
    Plug 'airblade/vim-gitgutter'

    " indentpython.vim
    Plug 'vim-scripts/indentpython.vim'

    " syntastic
    Plug 'vim-syntastic/syntastic'

    " flake8
    Plug 'nvie/vim-flake8'

    " vim-virtualenv
    Plug 'jmcantrell/vim-virtualenv'
call plug#end()

" ========================================================
" 基本设置
" ========================================================
filetype plugin indent on

set encoding=utf-8
set nu
set relativenumber
set nobackup
set ruler
set laststatus=2
set scrolloff=1
set tags=./tags;,tags,/usr/local/etc/systags
set expandtab
set textwidth=120
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set wildmenu
set clipboard+=unnamed

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

" ========================================================
" 配色设置
" ========================================================
set guifont=IBMPlexMono-Regular:h17
if has('gui_running')
    " set bg=light
    set bg=dark
    colorscheme gruvbox
else
    colorscheme zenburn
endif
 
" ========================================================
" 键盘映射设置
" ========================================================
let mapleader=";"

nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" 修改光标上下键一次移动一个屏幕行
nnoremap <Up>       gk
inoremap <Up>       <C-O>gk
nnoremap <Down>     gj
inoremap <Down>     <C-O>gj

" 切换窗口的键映射
nnoremap <C-Tab>    <C-W>w
inoremap <C-Tab>    <C-O><C-W>w
nnoremap <C-S-Tab>  <C-W>W
inoremap <C-S-Tab>  <C-O><C-W>W

au BufRead,BufNewFile *.go set expandtab
au BufNewFile,BufRead *.py set expandtab
au BufRead,BufNewFile *.js, *.html, *.css
            \ set tabstop=2
            \ set softtabstop=2
            \ set shiftwidth=2

" ========================================================
" 设置 NerdTree
" ========================================================
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swp', '\.git', '\~$']

nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>r :NERDTreeRefreshRoot<CR>

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" ========================================================
" golang 配置
" ========================================================
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_fmt_command='goimports'
let g:go_autodetect_gopath=1
let g:go_list_type='quickfix'

let g:go_version_warning=1
let g:go_highlight_types=1
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_function_calls=1
let g:go_highlight_operators=1
let g:go_highlight_extra_types=1
let g:go_highlight_methods=1
let g:go_highlight_generate_tags=1

let g:godef_split=2

" ========================================================
" airline 配置
" ========================================================
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline#extensions#tabline#formatter='unique_tail_improved'


" ========================================================
" tagbar 配置
" ========================================================
nmap <leader>t  :TagbarToggle<CR>


" ========================================================
" ctrlp 配置
" ========================================================
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'


" ========================================================
" python 配置
" ========================================================
let python_highlight_all=1
syntax on
