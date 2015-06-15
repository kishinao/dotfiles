" ============================================================
" basic
" ============================================================
syntax on
set nocompatible

" display----------------------------------------------
set number
set ruler
set laststatus=2
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
set shiftwidth=4
set softtabstop=4
set noet

set backspace=indent,eol,start
set wildmenu
set formatoptions+=mM
set whichwrap=b,s,h,l,[,],<,>
set mouse=a
set ttymouse=xterm2

" colorscheme----------------------------------------------
" colorscheme koehler
"colorscheme hybrid
set t_Co=256

" 罫線----------------------------------------------
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    "autocmd WinLeave * set nocursorcolumn
    autocmd WinEnter,BufRead * set cursorline
    "autocmd WinEnter,BufRead * set cursorcolumn
augroup END

" search----------------------------------------------
set history=100
set ignorecase
set smartcase
set wrapscan

" for Whitespace----------------------------------------------
" highlight WhitespaceEOL ctermbg=red guibg=red
" match WhitespaceEOL /\s\+$/
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\(\s\+$\|　\)/
augroup END

" key map edit------------------------------------------------
inoremap <C-J> <ESC>


" ============================================================
" plugin
" ============================================================

" neobundle---------------------------------------------------
set nocompatible               " Be iMproved
filetype off                   " Required!
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/neocomplcache'
    NeoBundle 'Shougo/neosnippet'
    " 後に機能追加する
    " NeoBundle 'Shougo/unite.vim'
    " NeoBundle 'Shougo/vimproc'
    NeoBundle 'Lokaltog/vim-powerline'
    NeoBundle 'scrooloose/nerdtree'
    NeoBundle 'thinca/vim-quickrun'
    NeoBundle 'nvie/vim-flake8'
    NeoBundle 'Shougo/vimshell'
    NeoBundle 'w0ng/vim-hybrid'
    NeoBundle 'nanotech/jellybeans.vim'
    NeoBundle 'scrooloose/syntastic'
call neobundle#end()

filetype plugin indent on     " Required!
" Installation check.
if neobundle#exists_not_installed_bundles()
    echomsg 'Not installed bundles : ' .
           \ string(neobundle#get_not_installed_bundle_names())
    echomsg 'Please execute ":NeoBundleInstall" command.'
    "finish
endif


" NERDTree---------------------------------------------------
let file_name = expand("%")
if has('vim_starting') &&  file_name == ""
    autocmd VimEnter * NERDTree ./
endif
" NERDTreeToggle Keymap
nmap <silent> <C-E> :NERDTreeToggle<CR>


" neocomplache---------------------------------------------------
let g:neocomplcache_enable_at_startup = 1

" Enable omni completion. Not required if they are already set elsewhere in .vimrc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" neosnippet---------------------------------------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" quickrun settings---------------------------------------------------
autocmd BufWinEnter,BufNewFile *_test.py set filetype=python.test

" Space q でquickrunを実行するようにしている
silent! map <unique> <Space>r <Plug>(quickrun)

let g:quickrun_config = {}

let g:quickrun_config._ = {'runner' : 'vimproc'}

"let g:quickrun_config['*'] = {'runmode': 'async:remote:vimproc'}

let g:quickrun_config['python.test'] = {'command': 'nosetests', 'cmdopt': '-s -v --nologcapture', 'hook/shebang/enable' : 0}
"let g:quickrun_config['python.test'] = {'command': 'nosetests', 'cmdopt': '-s -v --nologcapture -a'}

" for rspec conf is below
"let g:quickrun_config._ = {'runner' : 'vimproc'}
"let g:quickrun_config['ruby.rspec'] = {'command': 'rspec', 'cmdopt': '-cfs'}
""let g:quickrun_config['*'] = {'runmode': 'async:remote:vimproc'}
"
"augroup UjihisaRSpec
"  autocmd!
"  autocmd BufWinEnter,BufNewFile *_rspec.ruby set filetype=ruby.rspec
"augroup END
"
"
nnoremap [quickrun] <Nop>
nmap <Space>k [quickrun]
nnoremap <silent> [quickrun]r :call QRunRspecCurrentLine()<CR>
fun! QRunRspecCurrentLine()
  let line = line(".")
  exe ":QuickRun -cmdopt '-s -v --nologcapture -a " . '"now"' . "'"
endfun

" window risezer---------------------------------------------------
let g:winresizer_enable = 1
let g:winresizer_start_key = '<C-F>'


" ============================================================
" for python edit
" ============================================================
filetype plugin on
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl expandtab tabstop=8 shiftwidth=4 softtabstop=4
" autocmd FileType python setl cindent
autocmd FileType python setl textwidth=80

" Folding
setl foldmethod=indent
setl foldlevel=99

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


" ============================================================
" for javascript edit
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
