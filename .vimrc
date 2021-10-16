syntax enable 
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai
set si
set wrap
set fileencodings=ucs-bom,utf-8,utf-16,gb2312,gbk,big5,gb18030,latin1
set encoding=utf8
filetype plugin on
filetype indent on
set history=5000
set autoread
set so=7
let $LANG='en'
set langmenu=en
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
set undodir=~/.vim/undodir
set backupdir=~/.vim/backupdir
set directory=~/.vim/swapdir

set noerrorbells
set novisualbell
"set spell spelllang=en
set autochdir
set guifont=Unifont\ Medium\ 13
colorscheme industry
set background=dark
"以下为rust-analyzer和ALE插件
filetype plugin indent on
let g:ale_linters = {'rust': ['analyzer']}
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1

"以下为cscope需要的设置
set csprg=gtags-cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-
set csto=0
set cscopetag
set cst

" 记住上次打开的位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
