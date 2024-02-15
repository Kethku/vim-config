(local paq (require "paq"))

(paq:setup {:clone_args ["-c core.symlinks=true" "--depth=1" "--recurse-submodules" "--shallow-submodules" "--no-single-branch"]})

(paq [
 ;; Libraries
 "nvim-lua/popup.nvim"
 "nvim-lua/plenary.nvim"
 "nvim-telescope/telescope.nvim"

 ;; Appearance
 "ellisonleao/gruvbox.nvim"
 "ryanoasis/vim-devicons"
 "nvim-lualine/lualine.nvim"
 "kyazdani42/nvim-web-devicons"
 "romgrk/barbar.nvim"
 "lewis6991/satellite.nvim"

 ;; General Settings
 "olical/nfnl"
 "tpope/vim-sleuth"
 "voldikss/vim-floaterm"
 "kethku/golden-ratio"
 "yuttie/comfortable-motion.vim"
 "nvim-treesitter/nvim-treesitter"

 ;; Projects
 "nvim-telescope/telescope-project.nvim"

 ;; LSP
 "williamboman/mason.nvim"
 "williamboman/mason-lspconfig.nvim"
 "neovim/nvim-lspconfig"
 {1 "j-hui/fidget.nvim" :branch "legacy"}
 "glepnir/lspsaga.nvim"
 "smjonas/inc-rename.nvim"
 "mfussenegger/nvim-dap"
 "ldelossa/nvim-dap-projects"
 "theHamsta/nvim-dap-virtual-text"
 "rcarriga/nvim-dap-ui"
 "folke/lsp-colors.nvim"
 "folke/trouble.nvim"
 "folke/neodev.nvim"

 ;; Completion
 "Olical/conjure"
 "ms-jpq/coq_nvim"
 "github/copilot.vim"

 ;; Key Bindings
 "tpope/vim-commentary"
 "folke/which-key.nvim"
 "ggandor/leap.nvim"])
