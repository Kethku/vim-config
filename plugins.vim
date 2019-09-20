" Setup
call plug#begin('~/AppData/Local/nvim/plugged')

  " Appearance
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'morhetz/gruvbox'
  Plug 'sickill/vim-monokai'
  Plug 'lifepillar/vim-solarized8'
  Plug 'roman/golden-ratio'
  Plug 'airblade/vim-gitgutter'
  Plug 'ryanoasis/vim-devicons'
  Plug 'yuttie/comfortable-motion.vim'
  Plug 'gcmt/taboo.vim'

  " General Settings
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-endwise'
  Plug 'jiangmiao/auto-pairs'

  " File Management
  Plug 'tpope/vim-vinegar'

  " Completion
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  " Git
  Plug 'tpope/vim-fugitive'

  " Key Bindings
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'liuchengxu/vim-which-key'

  " Typescript
  Plug 'leafgarland/typescript-vim'
  Plug 'ianks/vim-tsx'

  " C#
  Plug 'neovim/nvim.net'

  " Powershell
  Plug 'PProvost/vim-ps1'

" Cleanup
call plug#end()
