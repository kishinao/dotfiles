"---------------------------------------------------
" WinResizer 
"---------------------------------------------------
" This is simple plugin to resize window size 
" for someone using vim with split windows  
"
" ========================================
" start 'resize mode' key
" <C-E> or g:winresizer_start_key defined by .vimrc
"
" If you don't need this function,
" define global variable below in .vimrc
"
" let g:winresizer_enable
"
" keymap of [resize window mode]
" h : expand window size to left
" j : expand window size to down
" k : expand window size to up
" l : expand window size to right
" q : cancel resize window and escepe [resize window mode]
" Enter : fix and escape 

" default start resize window key mapping
let s:default_mapping = '<C-E>'

if !exists('g:winresizer_vert_resize')
  let g:winresizer_vert_resize = 10
endif

if !exists('g:winresizer_horiz_resize')
  let g:winresizer_horiz_resize = 3
endif

if !exists('g:winresizer_start_key')
  let g:winresizer_start_key = s:default_mapping
endif

if !exists('g:winresizer_enable')
  let g:winresizer_enable = 1
endif

" If you define 'g:win_resizer_start_key' in .vimrc, 
" will be started resize window by 'g:win_resizer_start_key' 

exec 'nnoremap ' . g:winresizer_start_key .' :ResizeWinSize<CR>'

com! ResizeWinSize call ResizeWinSize()

fun! ResizeWinSize()
  if g:winresizer_enable == 0
    return
  endif

  echo '[resize window mode]... "Enter": OK , "q": Cancel'

  let l:move_map = {'left':'104', 'down':'106', 'up':'107', 'right':'108'}

  let l:behavior = s:getResizeBehavior(l:move_map)
  let l:left_resize = l:behavior[l:move_map['left']].g:winresizer_vert_resize
  let l:right_resize = l:behavior[l:move_map['right']].g:winresizer_vert_resize
  let l:up_resize = l:behavior[l:move_map['up']].g:winresizer_horiz_resize
  let l:down_resize = l:behavior[l:move_map['down']].g:winresizer_horiz_resize

  let l:rest = winrestcmd()

  while 1
    let l:c=getchar()
    if l:c == l:move_map['left'] "h
      exec ':vertical resize '.l:left_resize
    elseif l:c == l:move_map['down'] "j
      exec ':resize '.l:down_resize
    elseif l:c == l:move_map['up'] "k
      exec ':resize '.l:up_resize
    elseif l:c == l:move_map['right'] "l
      exec ':vertical resize '.l:right_resize
    elseif l:c == '113' "q
      exec l:rest
      echo "Canceled!"
      break
    elseif l:c == '13' "Enter
      echo "Finished!"
      break
    endif
    exec ":redraw"
  endwhile
endfun

fun! s:getResizeBehavior(move_map)
  let signs = {'left':'-', 'down':'+', 'up':'-', 'right':'+'}
  let result = {}
  let ei = s:getEdgeInfo()
  if !ei['left'] && ei['right']
    let signs['left'] = '+'
    let signs['right'] = '-'
  endif
  if !ei['up'] && ei['down']
    let signs['up'] = '+'
    let signs['down'] = '-'
  endif
  for direct in keys(a:move_map)
    exec 'let result["' .a:move_map[direct]. '"] = "' . signs[direct] . '"' 
  endfor
  return result
endfun

fun! s:getOppositeSign(sign)
  let sign = '+'
  if a:sign == '+'
    let sign = '-'
  endif
  return sign
endfun

" when value is 1 in return dictionary, 
" current window has edge in direction of dictionary key name
fun! s:getEdgeInfo()
  let chk_direct = {'h':'left', 'j':'down', 'k':'up', 'l':'right'}
  let result = {}
  for direct in keys(chk_direct)
    exec 'let result["' .chk_direct[direct]. '"] = ' . !s:canMove(direct)
  endfor
  return result
endfun

fun! s:canMove(direct)
  let from = winnr()
  exe "wincmd " . a:direct
  let to = winnr()
  exe from . "wincmd w"
  return from != to
endfun
