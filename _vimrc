set fileencodings=ucs-bom,utf-8,utf-16,gb2312,gbk,big5,gb18030,latin1
set encoding=utf8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set wildmenu
set guifont=Unifont:h12

syntax enable
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai
set si
set wrap
filetype plugin on
filetype indent on
set history=5000
set autoread
set so=7
let $LANG='en'
set langmenu=en
set ffs=unix,dos,mac
set ruler
set nu
set hid
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mouse=a
set undofile
set undodir=C:\Users\chai8\vimfiles\undodir
set backupdir=C:\Users\chai8\vimfiles\backupdir
set directory=C:\Users\chai8\vimfiles\swapdir


set noerrorbells
set novisualbell
"set spell spelllang=en
set autochdir
colorscheme industry

" 记住上次打开的位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
