(module module.plugins
  {require {paq paq-nvim}})

(def- paq paq.paq)

;; Appearance
(paq "folke/lsp-colors.nvim")
(paq "vim-airline/vim-airline")
(paq "vim-airline/vim-airline-themes")
(paq "morhetz/gruvbox")
(paq "ryanoasis/vim-devicons")
(paq "kyazdani42/nvim-web-devicons")
(paq "romgrk/barbar.nvim")

;; General Settings
(paq "tpope/vim-sleuth")
(paq "tpope/vim-endwise")
(paq "tpope/vim-obsession")
(paq "qpkorr/vim-bufkill")
(paq "kethku/vim-floaterm")
(paq "yuttie/comfortable-motion.vim")
(paq "kethku/golden-ratio")

;; File Management
;; (paq "c:/dev/Projects/vim-balsamic")

;; LSP
(paq "neovim/nvim-lspconfig")

;; Completion
(paq "nvim-lua/popup.nvim")
(paq "nvim-lua/plenary.nvim")
(paq "nvim-telescope/telescope.nvim")
(paq "Olical/conjure")
(paq "ms-jpq/coq_nvim")
(paq "tami5/compe-conjure")

;; Git
(paq "airblade/vim-gitgutter")

;; Key Bindings
(paq "tpope/vim-commentary")
(paq "tpope/vim-surround")
(paq "liuchengxu/vim-which-key")
