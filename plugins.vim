" Setup
set runtimepath+=~/AppData/Local/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/AppData/Local/nvim/dein')
  call dein#begin('~/AppData/Local/nvim/dein')

  " Appearance
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('morhetz/gruvbox')
  call dein#add('roman/golden-ratio')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('yuttie/comfortable-motion.vim')
  call dein#add('gcmt/taboo.vim')
  call dein#add('tpope/vim-markdown')
  call dein#add('wsdjeg/dein-ui.vim')

  " General Settings
  call dein#add('tpope/vim-sleuth')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-obsession')

  " File Management
  call dein#add('c:/dev/Projects/vim-balsamic')

  " Completion
  call dein#add('neoclide/coc.nvim', { 'rev': 'release' })
  call dein#add('junegunn/fzf', { 'merged': 0 })
  call dein#add('junegunn/fzf.vim')

  " Git
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')

  " Key Bindings
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-surround')
  call dein#add('liuchengxu/vim-which-key')
  call dein#add('easymotion/vim-easymotion')

  " Typescript
  call dein#add('leafgarland/typescript-vim')
  call dein#add('ianks/vim-tsx')

  " Cleanup
  call dein#end()
  call dein#save_state()
end
