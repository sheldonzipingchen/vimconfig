call plug#begin()
    Plug 'morhetz/gruvbox'

    Plug 'preservim/nerdtree'
call plug#end()

" ========================================================
" 基本设置
" ========================================================
filetype plugin indent on

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
colorscheme gruvbox
 
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

" ========================================================
" 设置 NerdTree
" ========================================================
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

