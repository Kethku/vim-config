let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

set background=dark
colorscheme gruvbox
let g:airline_theme='gruvbox'

set guifont=Fira\ Code:h14

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_z = '%3p%% %3l/%L:%3v'
let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0B6"

filetype plugin indent on

set termguicolors
set mouse=a
set expandtab
set hlsearch
set ignorecase
set smartcase
set clipboard=unnamed
set timeoutlen=100
set shell=pwsh
