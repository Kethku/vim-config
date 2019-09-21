" LEADER "
""""""""""

let g:mapleader = "\<Space>"
let g:maplocalleader = "."
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map = {}

let g:which_key_map.v = { 'name' : '+vim' }
nnoremap <silent> <leader>vr :source $MYVIMRC<CR>
let g:which_key_map.v.r = 'reload config'
nnoremap <silent> <leader>vi :source $MYVIMRC<CR>:call dein#install()<CR>
let g:which_key_map.v.i = 'install plugins'
nnoremap <silent> <leader>vu :source $MYVIMRC<CR>:call dein#update()<CR>
let g:which_key_map.v.u = 'update plugins'
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

let g:which_key_map.f = { 'name' : '+file' }
  nnoremap <silent> <leader>fr :History<CR>
  let g:which_key_map.f.r = 'recent file'
nnoremap <silent> <leader>fs :w<CR>
let g:which_key_map.f.s = 'save file'

let g:which_key_map.k = { 'name' : '+kill' }
nnoremap <silent> <leader>kw :wq<CR>
let g:which_key_map.k.w = 'kill window'

let g:which_key_map.t = { 'name' : '+terminal' }
nmap <silent> <leader>tt <Esc>:tabnew<CR>:TabooRename Terminal<CR>:edit term://pwsh<CR>
let g:which_key_map.t.t = 'new terminal tab'

let g:which_key_map[';'] = { 'name' : '+commentary' }
nnoremap <silent> <leader>;; :.Commentary<CR>
let g:which_key_map[';'][';'] = 'current line'

call which_key#register('<Space>', 'g:which_key_map')

" CoC "
""""""""""

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <C-.> <Plug>(coc-codeaction)
vmap <silent> <C-.> <Plug>(coc-codeaction)
nnoremap <silent> gh :<C-u>call CocAction('doHover')<CR>

" VISUAL "
""""""""""

vnoremap < <gv
vnoremap > >gv
vnoremap ; :Commentary<CR>

" Terminal "
""""""""""""

tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"


" Tabs "
""""""""

inoremap <silent> <C-Tab> :tabn<CR>
inoremap <silent> <C-S-Tab> :tabp<CR>
nnoremap <silent> <C-Tab> :tabn<CR>
nnoremap <silent> <C-S-Tab> :tabp<CR>
vnoremap <silent> <C-Tab> :tabn<CR>
vnoremap <silent> <C-S-Tab> :tabp<CR>
tnoremap <silent> <C-Tab> <c-\><c-n>:tabn<CR>
tnoremap <silent> <C-S-Tab> <c-\><c-n>:tabp<CR>
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" Scrolling "
"""""""""""""

nnoremap <silent> <down> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <up> :call comfortable_motion#flick(-100)<CR>

" GENERAL "
"""""""""""

nnoremap <ESC> :noh<CR>
