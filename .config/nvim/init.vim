" ----- General -----
" Don't write backup file if vim is being called by 'crontab -e'
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by 'chpass'
au BufWrite /private/etc/pw.* set nowritebackup

syntax on
set number
set modelines=0
set nocompatible
set backspace=2
set smarttab
set noswapfile
set wrap
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
set clipboard=unnamed
set splitbelow
set noshowmode
set laststatus=2

" Config for rendering
set lazyredraw
set ttyfast

" Terminal-emulator config
tnoremap <silent> <ESC> <C-\><C-n>
" If neovim-terminal is active, this config hide line number.
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber

" Python3 Path
let g:python3_host_prog = expand('$HOME/.venv/nvim/bin/python3')


" ----- dein.vim -----
let s:dein_dir = expand('$HOME/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    let g:rc_dir    = expand('$HOME/.config/nvim/dein')
    let s:toml      = g:rc_dir . '/dein.toml'
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
filetype plugin indent on

" ----- Syntax Highlight -----
" Python
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" AppleScript
autocmd bufnewfile,bufread *.scpt,*.applescript :setl filetype=applescript
autocmd FileType applescript :inoremap <buffer> <S-CR>  ￢<CR> 

" ----- NERDTree -----
let g:NERDTreeShowBookmarks = 0
let NERDTreeMinimalUI=1

" Config for opening a file
if argc() == 0 || argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
    autocmd vimenter * NERDTree
else
    autocmd vimenter * NERDTree | wincmd p
endif

" Config for closeing a file
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTreeToggle Ctrl-T
map <silent><C-t> :NERDTreeToggle<CR>

" ----- deoplete -----
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#python_path = g:python3_host_prog


" ----- lightline -----
" Config for status line 
let g:lightline = {
\'colorscheme': 'jellybeans',
\'active': {
\  'left': [ [ 'mymode', 'paste' ], [ 'myreadonly', 'absolutepath', 'mymodified' ] ],
\  'right': [ [ 'mylineinfo' ], [ 'mypercent' ], [ 'ale', 'myfileformat', 'myfileencoding', 'myfiletype' ] ]
\},
\'inactive': {
\  'left': [['absolutepath']],
\  'right': [[]]
\},
\'component_expand':{
\  'mymode': 'MyMode',
\  'mylineinfo': 'MyLineinfo',
\  'mypercent': 'MyPercent',
\  'myfiletype': 'MyFiletype',
\  'myfileformat': 'MyFileformat',
\  'myfileencoding': 'MyFileencoding',
\},
\  'component_function': {
\  'mymodified': 'MyModified',
\  'myreadonly': 'LightlineReadonly',
\  'ale': 'LLAle',
\}
\}

" functions for lightline
function! LLAle()
  let l:count = ale#statusline#Count(bufnr(''))
  let l:errors = l:count.error + l:count.style_error
  let l:warnings = l:count.warning + l:count.style_warning
  return l:count.total == 0 ? '' : 'E:' . l:errors . ' W:' . l:warnings
endfunction

function! LightlineVisible()
  let fname = expand('%:t')
  return !(fname =~ 'NERD_tree')
endfunction

function! MyMode()
    return LightlineVisible() ? '%{lightline#mode()}' : ''
endfunction

function! MyReadonly()
    return LightlineVisible() && &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyModified()
    return LightlineVisible() && &modifiable && &modified ? '+' : ''
endfunction

function! MyAbsolutepath()
    return LightlineVisible() ? '%F' : ''
endfunction

function! MyFileformat()
    return LightlineVisible() ? '%{&fileformat}' : ''
endfunction

function! MyFiletype()
    return LightlineVisible() ? '%{strlen(&filetype)?&filetype:"no ft"}' : ''
endfunction

function! MyFileencoding()
    return LightlineVisible() ? '%{strlen(&fenc)?&fenc:&enc}' : ''
endfunction

function! MyPercent()
    return LightlineVisible() ? '%3p%%' : ''
endfunction

function! MyLineinfo()
    return LightlineVisible() ? '%3l:%-2v' : ''
endfunction

" ----- ale -----
let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 0
let g:ale_python_flake8_executable = g:python3_host_prog
let g:ale_python_flake8_options = '-m flake8'

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" ----- Colorscheme -----
" ColorScheme Rewrite
let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}
colorscheme jellybeans

highlight SignColumn ctermbg=none
highlight ALEErrorSign ctermfg=88
highlight ALEWarningSign ctermfg=20
highlight VertSplit ctermfg=236 ctermbg=236
highlight StatusLine ctermfg=236 ctermbg=236
highlight StatusLineNC ctermfg=236 ctermbg=236
highlight clear ALEError
highlight clear ALEWarning
