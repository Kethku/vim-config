let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

set background=dark
colorscheme gruvbox
let g:airline_theme='gruvbox'

set guifont=Fira\ Code:h14

" Airline
let g:airline_powerline_fonts = 1
let g:airline_section_z = '%3p%% %3l/%L:%3v'
let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0B6"
" Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tabline#buffers_label = 'B'
let g:airline#extensions#tabline#tabs_label = 'T'
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:markdown_fenced_languages = ['javascript', 'typescript', 'js=javascript']

filetype plugin indent on

set termguicolors
set mouse=a
set expandtab
set hlsearch
set ignorecase
set smartcase
set clipboard=unnamed
set timeoutlen=100
