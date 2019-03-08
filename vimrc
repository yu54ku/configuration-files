" General
au BufWrite /private/tmp/crontab.* set nowritebackup
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

" 水平分割時，新しいウインドウを下に生成
set splitbelow
" 端末サイズ
set termwinsize=7x0

"-----------------------------
" dein.vim
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    " プラグインリストを収めた TOML ファイル
    " 予め TOML ファイル（後述）を用意しておく
    let g:rc_dir    = expand('~/.vim/rc')
    let s:toml      = g:rc_dir . '/dein.toml'
    " let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

    " TOML を読み込み、キャッシュしておく
    call dein#load_toml(s:toml,      {'lazy': 0})
    " call dein#load_toml(s:lazy_toml, {'lazy': 1})
    " 設定終了
    call dein#end()
    call dein#save_state()
endif
" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
filetype plugin indent on

"-----------------------------
" vim-markdown
let g:vim_markdown_folding_disabled=1

"-----------------------------
" neocomplete, jedi-vim
let g:neocomplete#enable_at_startup = 1

autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType python setlocal completeopt-=preview
let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'


"-----------------------------
" Python
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class


"-----------------------------
" AppleScript
autocmd bufnewfile,bufread *.scpt,*.applescript :setl filetype=applescript
autocmd FileType applescript :inoremap <buffer> <S-CR>  ￢<CR> 


"-----------------------------
" Markdown(previm)
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

let g:previm_open_cmd = 'open -a safari'
let g:previm_enable_realtime = 1


"-----------------------------
" NERDTree
let g:NERDTreeShowBookmarks = 1
let NERDTreeMinimalUI=1

"" 引数なしの場合NERDTreeを起動
autocmd vimenter * if !argc() | NERDTree | endif
" autocmd vimenter * NERDTree

"" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd bufenter * if (winnr("$") == 2 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | q | endif

" Colorscheme
let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}

colorscheme jellybeans

"" vim-minimap
autocmd vimenter * Minimap

filetype plugin on


