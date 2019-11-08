let &t_AB='\e[48;5;%dm'
let &t_AF='\e[38;5;%dm'

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
let g:airline_section_z = '%3p%% %3l/%L:%3v'
let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0B6"
let g:airline#extensions#coc#enabled = 1
" Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tabline#buffers_label = 'B'
let g:airline#extensions#tabline#tabs_label = 'T'
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline_section_z = '%3l/%L:%3v'
let g:airline_section_warning = ''
let g:airline_section_error = ''

let g:markdown_fenced_languages = ['javascript', 'typescript', 'js=javascript']

let g:gruvbox_invert_selection = 1

let g:floaterm_winblend = 20
let g:floaterm_position = 'center'

filetype plugin indent on

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
