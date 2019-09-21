" Setup
set runtimepath+=~/AppData/Local/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/AppData/Local/nvim/dein')
  call dein#begin('~/AppData/Local/nvim/dein')

  " Appearance
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('morhetz/gruvbox')
  call dein#add('sickill/vim-monokai')
  call dein#add('lifepillar/vim-solarized8')
  call dein#add('roman/golden-ratio')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('yuttie/comfortable-motion.vim')
  call dein#add('gcmt/taboo.vim')
  call dein#add('tpope/vim-markdown')

  " General Settings
  call dein#add('tpope/vim-sensible')
  call dein#add('tpope/vim-sleuth')
  call dein#add('tpope/vim-endwise')
  call dein#add('jiangmiao/auto-pairs')

  " File Management
  call dein#add('tpope/vim-vinegar')

  " Completion
  call dein#add('neoclide/coc.nvim', { 'rev': 'release' })
  call dein#add('junegunn/fzf', { 'merged': 0 })
  call dein#add('junegunn/fzf.vim')

  " Git
  call dein#add('tpope/vim-fugitive')

  " Key Bindings
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-surround')
  call dein#add('liuchengxu/vim-which-key')

  " Typescript
  call dein#add('leafgarland/typescript-vim')
  call dein#add('ianks/vim-tsx')

  " Powershell
  call dein#add('PProvost/vim-ps1')

  " Cleanup
  call dein#end()
  call dein#save_state()
end
