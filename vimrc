"{{{ basic
" -------------------------------------------------------
syntax on
set nocompatible
syntax enable
filetype plugin indent on

" display----------------------------------------------
set number
set ruler
set laststatus=2
"新しい行を作ったときに高度な自動インデントを行うset smartindent "行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
set shiftwidth=4
set softtabstop=4
set noet
set expandtab
set tabstop=2
set shiftwidth=2

set backspace=indent,eol,start
set wildmenu
set formatoptions+=mM
set whichwrap=b,s,h,l,[,],<,>
"set mouse=a
set ttymouse=xterm2
" }}}

" {{{ 罫線----------------------------------------------
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  "autocmd WinLeave * set nocursorcolumn
  autocmd WinEnter,BufRead * set cursorline
  "autocmd WinEnter,BufRead * set cursorcolumnn
augroup END
"}}}

" {{{ search----------------------------------------------
set history=100
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
" }}}

" {{{for Whitespace----------------------------------------------
" highlight WhitespaceEOL ctermbg=red guibg=red
" match WhitespaceEOL /\s\+$/
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\(\s\+$\|　\)/
augroup END
"}}}

" {{{ key map edit------------------------------------------------
nnoremap <silent> gp :bprevious<CR>
nnoremap <silent> gn :bnext<CR>
" }}}

"{{{ proc
" ============================================================
"if has('mac')
"  let g:vimproc_dll_path = '~/.vim/bundle/vimproc.vim/lib/vimproc_mac.so'
"elseif has('win32')
"  let g:vimproc_dll_path = $HOME . '.vim/bundle/vimproc.vim/autoload/vimproc_win32.dll'
"elseif has('win64')
"  let g:vimproc_dll_path = $HOME . '.vim/bundle/vimproc.vim/autoload/vimproc_win64.dll'
"endif
" }}}

" {{{ Plugin
call plug#begin('~/.vim/plugged')
Plug 'Shougo/neocomplcache'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/unite.vim'
Plug 'airblade/vim-gitgutter'
Plug 'kannokanno/previm'
Plug 'nanotech/jellybeans.vim'
Plug 'nvie/vim-flake8'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/syntastic'
Plug 'simeji/winresizer'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-fugitive'
Plug 'tyru/open-browser.vim'
Plug 'vim-scripts/grep.vim'
Plug 'w0ng/vim-hybrid'
Plug 'cocopon/vaffle.vim'
call plug#end()
" }}}

" {{{ colorscheme ----------------------------------------------
if &term =~ "xterm-256color" || "screen-256color"
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif
" colorscheme jellybeans
" }}}

" {{{ Neocomplcache
let g:neocomplcache_enable_at_startup = 1
" }}}

" {{{ Enable omni completion. Not required if they are already set elsewhere in .vimrc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" }}}

" {{{ neosnippet---------------------------------------------------
" Plugin key-mappings.
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"
"" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"
"" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" }}}

" {{{ quickrun settings---------------------------------------------------
let g:quickrun_config={'*': {'split': ''}}
set splitbelow
" }}}

" {{{ window risezer---------------------------------------------------
let g:winresizer_enable = 1
let g:winresizer_start_key = '<C-E>'
" }}}

" {{{ unite setting---------------------------------------------------
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
" }}}

" {{{ GitGutter
"let g:gitgutter_highlight_lines = 1
"let g:gitgutter_override_sign_column_highlight = 0
" 色変更
highlight GitGutterAdd ctermfg=green
highlight itGutterChangeLine ctermfg=yellow
highlight itGutterDeleteLine ctermfg=red
highlight itGutterChangeDeleteLine ctermfg=yellow
" 文字変更
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = 'm'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_modified_removed = 'ww'
" }}}

" {{{ Previm setting
au BufRead,BufNewFile *.md set filetype=markdown
"let g:previm_open_cmd = 'open -a chrome'
" }}}

" {{{ Vaffle Setting
nnoremap <Space>e :Vaffle<CR>
" if need keymap when open vaffle
"function! s:customize_vaffle_mappings() abort
"  "nmap q <Plug>(vaffle-quit)
"endfunction
"augroup vimrc_vaffle
"  autocmd!
"  autocmd FileType vaffle call s:customize_vaffle_mappings()
"augroup END
" }}}

" {{{for python edit
" ============================================================
filetype plugin on
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl expandtab tabstop=8 shiftwidth=4 softtabstop=4
" autocmd FileType python setl cindent
autocmd FileType python setl textwidth=80

" Excute python script C-P
function! s:ExecPy()
    exe "!" . &ft . " %"
:endfunction
command! Exec call <SID>ExecPy()
autocmd FileType python map <silent> <C-P> :call <SID>ExecPy()<CR>

" Execute pep8 keymap F8
autocmd FileType python map <F8> :!pep8 %<CR>

" show nosetests keymap C-N
autocmd FileType python map <C-N> :!nosetests % -s -v -a ''

" For Python_diction
autocmd FileType python let g:pydiction_location = '~/.vim/pydiction/complete-dict'
" }}}

" {{{ for Markdown edit
" ============================================================
au BufRead,BufNewFile *.md set filetype=markdown
" }}}

" {{{ for javascript edit
" ============================================================
let g:syntastic_mode_map = {
\ "mode" : "active",
\ "active_filetypes" : ["javascript", "json"],
\}
"if exists("current_compiler")
"  finish
"endif
"
"let current_compiler = "javascriptlint"
"
"if exists(":CompilerSet") != 2
"  command -nargs=* CompilerSet setlocal <args>
"endif
"
"let s:cpo_save = &cpo
"set cpo-=C
"
"CompilerSet makeprg=jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -process\ %
"
"CompilerSet errorformat=%f(%l):\ %m
"
"let &cpo = s:cpo_save
"unlet s:cpo_save
"
"autocmd FileType javascript :compiler javascriptlint
" }}}

" {{{ for ruby edit
" ============================================================
autocmd FileType ruby setl autoindent
autocmd FileType ruby setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType ruby setl expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType ruby setl textwidth=80
" }}}

" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
