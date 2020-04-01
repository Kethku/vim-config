if &compatible
  set nocompatible
endif

" Setup
set runtimepath+=~/AppData/Local/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/AppData/Local/nvim/dein')
  call dein#begin('~/AppData/Local/nvim/dein')

  " Aniseed
  call dein#add('Olical/aniseed', { 'rev': ''})
  call dein#add('bakpakin/fennel.vim')
  call dein#add('guns/vim-sexp')
  call dein#add('tpope/vim-sexp-mappings-for-regular-people')

  " Appearance
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('morhetz/gruvbox')
  call dein#add('kethku/golden-ratio')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('yuttie/comfortable-motion.vim')
  call dein#add('gcmt/taboo.vim')
  call dein#add('plasticboy/vim-markdown')
  call dein#add('wsdjeg/dein-ui.vim')

  " General Settings
  call dein#add('tpope/vim-sleuth')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-obsession')
  call dein#add('qpkorr/vim-bufkill')
  call dein#add('kethku/vim-floaterm')
  call dein#add('wellle/targets.vim')
  call dein#add('glacambre/firenvim', { 'hook_post_update': function('firenvim#install') })

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

lua require('aniseed.dotfiles')

runtime settings.vim
runtime bindings.vim
