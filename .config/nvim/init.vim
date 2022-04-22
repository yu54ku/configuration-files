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

set completeopt+=noinsert

" Terminal-emulator config
tnoremap <silent> <ESC> <C-\><C-n>
" If neovim-terminal is active, this config hide line number.
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber

" Python Path
let g:python3_host_prog = $PYENV_ROOT.'/versions/neovim/bin/python'
let g:python3_current_env_path = substitute(system('pyenv which python'), '\n', '', 'g')


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
let g:dein#auto_recache = 1


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

" ----- indentLine -----
" let g:indentLine_setConceal = 0

" ----- airline -----
let g:airline_theme = 'jellybeans'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_z = airline#section#create(['%4.4l:%4.4c'])


" ----- Colorscheme -----
"  ColorScheme Rewrite
let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}
colorscheme jellybeans

highlight SignColumn ctermbg=none
highlight VertSplit ctermfg=236 ctermbg=236
highlight StatusLine ctermfg=236 ctermbg=236
highlight StatusLineNC ctermfg=236 ctermbg=236
