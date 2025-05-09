set fileencodings=ucs-bom,utf-8,utf-16,gb2312,gbk,big5,gb18030,latin1
set encoding=utf8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set wildmenu

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
set undodir=~/.vim/undodir
set backupdir=~/.vim/backupdir
set directory=~/.vim/swapdir
set guifont=Unifont\ Medium\ 13

" netrw
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=20
let g:netrw_chgwin=1
let g:netrw_preview=1
set switchbuf=useopen,usetab

" folding
set foldmethod=syntax


set noerrorbells
set novisualbell
"set spell spelllang=en
set autochdir
colorscheme industry
set backspace=indent,eol,start  " more powerful backspacing
set background=dark

"以下为rust-analyzer和ALE插件
filetype plugin indent on
let g:ale_linters = {'rust': ['analyzer'], 'python': ['pylsp']}
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1

"以下为cscope需要的设置
set csprg=gtags-cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-
set csto=0
set cscopetag
set cst

if filereadable("GTAGS")
  cs add GTAGS
elseif $CSCOPE_DB != ""
  cs add $CSCOPE_DB
endif

" 记住上次打开的位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

function! Llm()

  let url = "http://127.0.0.1:8080/completion"

  " Get the content of the current buffer
  let buffer_content = join(getline(1, '$'), "\n")

  " Create the JSON payload
  let json_payload = {"temp":0.72,"top_k":100,"top_p":0.73,"repeat_penalty":1.100000023841858,"n_predict":256,"stop": ["\n\n\n"],"stream": v:false}
  let json_payload.prompt = buffer_content

  " Define the curl command
  let curl_command = 'curl -k -s -X POST -H "Content-Type: application/json" -d @- ' . url
  let response = system(curl_command, json_encode(json_payload))

  " Extract the content field from the response
  let content = json_decode(response).content

  let split_newlines = split(content, '\n', 1)

  " Insert the content at the cursor position
  call setline(line('.'), [ getline('.') . split_newlines[0] ] + split_newlines[1:])
endfunction

command! Llm call Llm()
noremap <F2> :Llm<CR>

function! Mlx()

  let url = "http://127.0.0.1:8080/v1/completions"

  " Get the content of the current buffer
  let buffer_content = join(getline(1, '$'), "\n")

  " Create the JSON payload
  let json_payload = {"temp":0.72,"top_k":100,"top_p":0.73,"repeat_penalty":1.100000023841858,"n_predict":256,"stop": ["\n\n\n"],"stream": v:false}
  let json_payload.prompt = buffer_content

  " Define the curl command
  let curl_command = 'curl -k -s -X POST -H "Content-Type: application/json" -d @- ' . url
  let response = system(curl_command, json_encode(json_payload))

  " Extract the content field from the response
  let content = json_decode(response).choices[0].text

  let split_newlines = split(content, '\n', 1)

  " Insert the content at the cursor position
  call setline(line('.'), [ getline('.') . split_newlines[0] ] + split_newlines[1:])
endfunction

command! Mlx call Mlx()
noremap <F3> :Mlx<CR>

augroup highlight_current_word
    au!
    au CursorHold * :exec 'match StatusLineTerm /\V\<' . escape(expand('<cword>'), '/\') . '\>/'
augroup END

set updatetime=1000

fu! SeeTab()
  if !exists("g:SeeTabEnabled")
    let g:SeeTabEnabled = 0
  end
  if g:SeeTabEnabled==0
    syn match leadspace /^\s\+/ contains=syntab
    exe "syn match syntab /\\s\\{" . &sw . "}/hs=s,he=s+1 contained"
    if has('gui_running')
        hi syntab guibg=Grey
    else
        hi syntab ctermbg=Grey
    endif
    let g:SeeTabEnabled=1
  else
    syn clear leadspace
    syn clear syntab
    let g:SeeTabEnabled=0
  end
endfunc
com! -nargs=0 Seetab :call SeeTab()

noremap <Up> gk
noremap! <Up> <C-O>gk
noremap <Down> gj
noremap! <Down> <C-O>gj

" define line highlight color
highlight LineHighlight ctermbg=darkgray guibg=darkgray
" highlight the current line
nnoremap <silent> <Leader>l :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>
" clear all the highlighted lines
nnoremap <silent> <Leader>c :call clearmatches()<CR>
