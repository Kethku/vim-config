(module module.plugins
  {require {paq paq}})

(def- paq paq.paq)

;; Appearance
(paq "folke/lsp-colors.nvim")
(paq "ellisonleao/gruvbox.nvim")
(paq "ryanoasis/vim-devicons")
(paq "nvim-lualine/lualine.nvim")
(paq "kyazdani42/nvim-web-devicons")
(paq "romgrk/barbar.nvim")
(paq "lewis6991/satellite.nvim")

;; General Settings
(paq "tpope/vim-sleuth")
(paq "tpope/vim-endwise")
(paq "tpope/vim-obsession")
(paq "voldikss/vim-floaterm")
(paq "yuttie/comfortable-motion.vim")
(paq "kethku/golden-ratio")
(paq "nvim-treesitter/nvim-treesitter")

;; LSP
(paq "williamboman/mason.nvim")
(paq "williamboman/mason-lspconfig.nvim")
(paq "neovim/nvim-lspconfig")
(paq "simrat39/rust-tools.nvim")
(paq "mfussenegger/nvim-dap")
(paq {1 "j-hui/fidget.nvim" :branch "legacy"})
(paq "glepnir/lspsaga.nvim")
(paq "smjonas/inc-rename.nvim")

;; Completion
(paq "nvim-lua/popup.nvim")
(paq "nvim-lua/plenary.nvim")
(paq "nvim-telescope/telescope.nvim")
(paq "Olical/conjure")
(paq "ms-jpq/coq_nvim")
(paq "github/copilot.vim")
(paq "aduros/ai.vim")

;; Grammar
(paq "jose-elias-alvarez/null-ls.nvim")

;; Key Bindings
(paq "tpope/vim-commentary")
(paq "tpope/vim-surround")
(paq "folke/which-key.nvim")
