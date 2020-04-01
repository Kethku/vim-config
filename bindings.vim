" Utils "
"""""""""

function! IsTerminalWindow(bufnumber)
  return getbufvar(a:bufnumber, '&buftype') == 'terminal'
        \ && getbufvar(a:bufnumber, 'floaterm_window') == 1
endfunction

function! FindTerminalWindow()
  for winnr in range(1, winnr('$'))
    if IsTerminalWindow(winbufnr(winnr))
      return winnr
    endif
  endfor
  return 0
endfunction

function! HideTerminal()
  let winnr = FindTerminalWindow()
  if winnr > 0
    execute winnr . ' wincmd q'
  endif
endfunction

function! SetupTerminal()
  let g:floaterm_width = &columns - 10
  let g:floaterm_height = &lines - 5
endfunction

function! ToggleTerminal()
  call SetupTerminal()
  set shell=pwsh
  FloatermToggle
  set shell=cmd
endfunction

function! NewTerminal()
  call SetupTerminal()
  set shell=pwsh
  FloatermNew
  set shell=cmd
endfunction

function! NextTerminal()
  call SetupTerminal()
  FloatermNext
endfunction

function! PreviousTerminal()
  call SetupTerminal()
  FloatermPrev
endfunction

function! SmartTabNext()
  if IsTerminalWindow(bufnr('%'))
    call NextTerminal()
  else
    tabn
  endif
endfunction

function! SmartTabPrev()
  if IsTerminalWindow(bufnr('%'))
    call PreviousTerminal()
  else
    tabp
  endif
endfunction

function! Okeydokey(args)
  silent execute "!pwsh -Command ok " . a:args
endfunction

command! -nargs=1 Ok call Okeydokey(<q-args>)
command! -nargs=1 OkLoc call Okeydokey(<q-args> . " " . resolve("%:p") . " " . line(".") . " " . col("."))


" LEADER "
""""""""""

let g:mapleader = "\<Space>"
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map = {}

let g:which_key_map.v = { 'name' : '+vim' }
nnoremap <silent> <leader>vr :source $MYVIMRC<CR>
let g:which_key_map.v.r = 'reload config'
nnoremap <silent> <leader>vu :source $MYVIMRC<CR>:call dein#update()<CR>
let g:which_key_map.v.u = 'update plugins'
nnoremap <silent> <leader>vi :source $MYVIMRC<CR>:call dein#install()<CR>
let g:which_key_map.v.i = 'install plugins'
let g:which_key_map.v.e = { 'name' : '+edit' }
nnoremap <silent> <leader>vei :e $MYVIMRC<CR>
let g:which_key_map.v.e.i = 'init.vim'
nnoremap <silent> <leader>veb :e $MYVIMRC\..\bindings.vim<CR>
let g:which_key_map.v.e.b = 'bindings.vim'
nnoremap <silent> <leader>vep :e $MYVIMRC\..\plugins.vim<CR>
let g:which_key_map.v.e.p = 'plugins.vim'
nnoremap <silent> <leader>ves :e $MYVIMRC\..\settings.vim<CR>
let g:which_key_map.v.e.s = 'settings.vim'

let g:which_key_map.q = { 'name' : '+quit' }
nnoremap <silent> <leader>qq :wqall<CR>
let g:which_key_map.q.q = 'quit and save everything'
nnoremap <silent> <leader>qr :Obsession ~/session.vim<CR>:!start neovide -S ~/session.vim<CR><CR>:wqall<CR>
let g:which_key_map.q.q = 'quit and reload'

let g:which_key_map.w = { 'name' : '+windows' }
nnoremap <silent> <leader>wh <C-w>h
let g:which_key_map.w.h = 'jump left'
nnoremap <silent> <leader>wj <C-w>j
let g:which_key_map.w.j = 'jump down'
nnoremap <silent> <leader>wk <C-w>k
let g:which_key_map.w.k = 'jump up'
nnoremap <silent> <leader>wl <C-w>l
let g:which_key_map.w.l = 'jump right'
nnoremap <silent> <leader>wy :vsplit<CR><Esc>
let g:which_key_map.w.y = 'split left'
nnoremap <silent> <leader>wu :split<CR><C-w>j<Esc>
let g:which_key_map.w.u = 'split down'
nnoremap <silent> <leader>wi :split<CR><Esc>
let g:which_key_map.w.i = 'split up'
nnoremap <silent> <leader>wo :vsplit<CR><C-w>l<Esc>
let g:which_key_map.w.o = 'split right'
nmap <silent> <leader>w= <Plug>(golden_ratio_resize)
let g:which_key_map.w['='] = 'auto resize'

let g:which_key_map.b = { 'name' : '+buffer' }
nnoremap <silent> <leader>bb :Buffers<CR>
let g:which_key_map.b.b = 'buffers'
nnoremap <silent> <leader>bh :bprevious<CR>
let g:which_key_map.b.h = 'previous'
nnoremap <silent> <leader>bl :bnext<CR>
let g:which_key_map.b.l = 'next'
nnoremap <silent> <leader>bk :bfirst<CR>
let g:which_key_map.b.k = 'first'
nnoremap <silent> <leader>bj :blast<CR>
let g:which_key_map.b.j = 'last'
nnoremap <silent> <leader>bd :BD<CR>
let g:which_key_map.b.d = 'delete'

let g:which_key_map.f = { 'name' : '+file' }
nnoremap <silent> <leader>fr :History<CR>
let g:which_key_map.f.r = 'recent file'
nnoremap <silent> <leader>fs :w<CR>
let g:which_key_map.f.s = 'save file'
nnoremap <silent> <leader>ff :CocCommand prettier.formatFile<CR>
let g:which_key_map.f.f = 'format file'

let g:which_key_map.k = { 'name' : '+kill' }
nnoremap <silent> <leader>kw :wq<CR>
let g:which_key_map.k.w = 'kill window'

let g:which_key_map.t = { 'name' : '+terminal' }
nmap <silent> <leader>tt <Esc>:call ToggleTerminal()<CR>
let g:which_key_map.t.t = 'Open Floating Terminal'
nmap <silent> <leader>tn <Esc>:call NewTerminal()<CR>
let g:which_key_map.t.n = 'New Floating Terminal'
nmap <silent> <leader>tl <Esc>:call NextTerminal()<CR>
let g:which_key_map.t.l = 'Next Floating Terminal'
nmap <silent> <leader>th <Esc>:call PreviousTerminal()<CR>
let g:which_key_map.t.h = 'Previous Floating Terminal'

let g:which_key_map[';'] = { 'name' : '+commentary' }
nnoremap <silent> <leader>;; :.Commentary<CR>
let g:which_key_map[';'][';'] = 'current line'

let g:which_key_map[' '] = { 'name' : '+easymotion' }
nmap <silent> <leader><leader>f <Plug>(easymotion-f)
let g:which_key_map[' '].f = 'f{char} jump to character'
nmap <silent> <leader><leader>F <Plug>(easymotion-F)
let g:which_key_map[' '].F = 'F{char} jump backwards to character'
nmap <silent> <leader><leader>t <Plug>(easymotion-t)
let g:which_key_map[' '].t = 't{char} jump to before character'
nmap <silent> <leader><leader>T <Plug>(easymotion-T)
let g:which_key_map[' '].T = 'T{char} jump backwards to after character'
nmap <silent> <leader><leader>w <Plug>(easymotion-w)
let g:which_key_map[' '].w = 'w jump to word'
nmap <silent> <leader><leader>W <Plug>(easymotion-W)
let g:which_key_map[' '].W = 'W jump to WORD'
nmap <silent> <leader><leader>b <Plug>(easymotion-b)
let g:which_key_map[' '].b = 'b jump backwards to word'
nmap <silent> <leader><leader>B <Plug>(easymotion-B)
let g:which_key_map[' '].B = 'B jump backwards to WORD'
nmap <silent> <leader><leader>e <Plug>(easymotion-e)
let g:which_key_map[' '].e = 'e jump to end of word'
nmap <silent> <leader><leader>E <Plug>(easymotion-E)
let g:which_key_map[' '].E = 'E jump to end of WORD'
let g:which_key_map[' '].g = { 'name' : '+back' }
nmap <silent> <leader><leader>ge <Plug>(easymotion-ge)
let g:which_key_map[' '].g.e = 'ge jump backwards to end of word'
nmap <silent> <leader><leader>gE <Plug>(easymotion-gE)
let g:which_key_map[' '].g.E = 'gE jump backwards to end of WORD'
nmap <silent> <leader><leader>j <plug>(easymotion-j)
let g:which_key_map[' '].j = 'j jump down to line'
nmap <silent> <leader><leader>k <plug>(easymotion-k)
let g:which_key_map[' '].k = 'k jump up to line'
nmap <silent> <leader><leader>n <plug>(easymotion-n)
let g:which_key_map[' '].n = 'n jump to search result'
nmap <silent> <leader><leader>N <plug>(easymotion-N)
let g:which_key_map[' '].N = 'N jump to previous search result'

nmap <leader>j <plug>(easymotion-overwin-f)
let g:which_key_map['J'] = 'jump to location'

call which_key#register('<Space>', 'g:which_key_map')

" CoC "
"""""""

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <C-.> <Plug>(coc-codeaction)
vmap <silent> <C-.> <Plug>(coc-codeaction)
nnoremap <silent> gh :<C-u>call CocAction('doHover')<CR>

" VISUAL "
""""""""""

vnoremap <silent> < <gv
vnoremap <silent> > >gv
vnoremap <silent> ; :Commentary<CR>
vnoremap <silent> <M-q> gq

" Terminal "
"""""""""""

tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<C-\><C-n>"

" Tabs "
""""""""

inoremap <silent> <C-Tab> <Esc>:call SmartTabNext()<CR>
inoremap <silent> <C-S-Tab> <Esc>:call SmartTabPrev()<CR>
nnoremap <silent> <C-Tab> :call SmartTabNext()<CR>
nnoremap <silent> <C-S-Tab> :call SmartTabPrev()<CR>
vnoremap <silent> <C-Tab> :call SmartTabNext()<CR>
vnoremap <silent> <C-S-Tab> :call SmartTabPrev()<CR>
tnoremap <silent> <C-Tab> <c-\><c-n>:call SmartTabNext()<CR>
tnoremap <silent> <C-S-Tab> <c-\><c-n>:call SmartTabPrev()<CR>

" Scrolling "
"""""""""""""

nnoremap <silent> <down> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <up> :call comfortable_motion#flick(-100)<CR>

" GENERAL "
"""""""""""

nnoremap <silent> - :Balsamic<CR>
nmap <silent> <ESC> :noh<CR>:call HideTerminal()<CR><Plug>(coc-float-hide)

nmap <silent> fd <ESC>
imap <silent> fd <ESC>
tmap <silent> fd <ESC>
cmap <silent> fd <ESC>
vmap <silent> fd <ESC>
