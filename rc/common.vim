filetype plugin indent on

set autoread
set laststatus=2
set noshowmode
set nobackup
set scrolloff=1
set tags=./tags;,tags,/usr/local/etc/systags
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
set ruler
set completeopt=menu,menuone,noselect

au FocusGained,BufEnter * checktime
au BufNewFile,BufRead *.js, *.html, *.css 
      \ set tabstop=2 
      \ set softtabstop=2
      \ set shiftwidth=2
au BufRead, BufNewFile *.py, *.pyw, *.c, *.h match BadWhitespace /\s\+$/
au BufRead,BufNewFile *.py set expandtab
au BufRead,BufNewFile *.go set expandtab

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

