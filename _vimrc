set fileencodings=ucs-bom,utf-8,utf-16,gb2312,gbk,big5,gb18030,latin1
set encoding=utf8
set wildmenu

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
set undofile
set undodir=C:\Users\hasee\vimfiles\undodir
set backupdir=C:\Users\hasee\vimfiles\backupdir
set directory=C:\Users\hasee\vimfiles\swapdir
set guifont=DejaVu_Sans_Mono_Unifont:h12

" netrw
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=20
set switchbuf=useopen,usetab

" folding
set foldmethod=syntax


set noerrorbells
set novisualbell
"set spell spelllang=en
set autochdir
colorscheme industry
set backspace=indent,eol,start  " more powerful backspacing

"以下为rust-analyzer和ALE插件
filetype plugin indent on
let g:ale_linters = {'rust': ['analyzer'], 'python': ['pylsp']}
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1

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
