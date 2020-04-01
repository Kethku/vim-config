set background=dark
colorscheme gruvbox
let g:airline_theme='gruvbox'

set guifont=Delugia\ Nerd\ Font:h12

set winblend=20
set pumblend=20

" disable netrw
let loaded_netrwPlugin = 1

" Airline
let g:airline_powerline_fonts = 1
let g:airline_section_z = '%3l/%L:%3v'
let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0B6"
let g:airline#extensions#coc#enabled = 1
let g:airline_section_warning = ''
let g:airline_section_error = ''
" Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tabline#buffers_label = 'B'
let g:airline#extensions#tabline#tabs_label = 'T'
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:markdown_fenced_languages = ['javascript', 'typescript', 'js=javascript']
let g:vim_markdown_folding_disabled = 1

let g:gruvbox_invert_selection = 1

let g:floaterm_winblend = 20
let g:floaterm_position = 'center'

let g:neovide_cursor_animation_length = 0.08
let g:neovide_refresh_rate = 144

function! FloatingFZF()
  let height = &lines
  let width = float2nr(&columns - (&columns * 2 / 10))

  let window_height = height / 3
  let col = float2nr((&columns - width) / 2)
  let col_offset = &columns / 10
  let opts = {
        \ 'relative': 'editor',
        \ 'row': height - window_height,
        \ 'col': col + col_offset,
        \ 'width': width * 2 / 1,
        \ 'height': window_height,
        \ 'style': 'minimal'
        \ }
  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)
  call setwinvar(win, '&winhl', 'NormalFloat:TabLine')
endfunction

let g:fzf_layout = { 'window': 'call FloatingFZF()' }

filetype plugin indent on

autocmd BufEnter * silent! lcd %:p:h

" set guicursor=n-v-c:block-Cursor
" set guicursor+=i:ver100-iCursor
set ve=block " All virtual text editing in block mode
set nonumber " Don't show line numbers
set termguicolors " Allow full color even in terminal
set mouse=a " Allow mouse events
set expandtab " Always use spaces instead of tabs
set hlsearch " Highlight words as I search them
set ignorecase " ignore casing of my searches
set smartcase
set clipboard=unnamed
set timeoutlen=100
set textwidth=120
set noshowmode
set hidden
set conceallevel=3
set nowrap
