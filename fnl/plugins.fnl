(local lazy (require "lazy"))

(fn _ [pkg config]
  (let [result (vim.deepcopy config)]
    (tset result 1 pkg)
    result))

(lazy.setup
  [;; Libraries
   "nvim-lua/popup.nvim"
   "nvim-lua/plenary.nvim"

   ;; Appearance
   (_ "rebelot/kanagawa.nvim"
      {:opts {:compile true
              :dimInactive false}})
   "ryanoasis/vim-devicons"
   "nvim-lualine/lualine.nvim"
   "kyazdani42/nvim-web-devicons"
   "romgrk/barbar.nvim"
   "lewis6991/satellite.nvim"
   "ellisonleao/gruvbox.nvim"

   ;; General Settings
   (_ "olical/nfnl"
      {:ft "fennel"})
   "tpope/vim-sleuth"
   (_ "voldikss/vim-floaterm"
      {:lazy false})
   "kethku/golden-ratio"
   "yuttie/comfortable-motion.vim"
   "nvim-treesitter/nvim-treesitter" 

   ;; Telescope
   "nvim-telescope/telescope.nvim"
   "nvim-telescope/telescope-frecency.nvim"
   "nvim-telescope/telescope-project.nvim"

   ;; LSP
   "williamboman/mason.nvim"
   "williamboman/mason-lspconfig.nvim"
   "neovim/nvim-lspconfig"
   (_ "j-hui/fidget.nvim"
      {:branch "legacy"})
   "glepnir/lspsaga.nvim"
   "smjonas/inc-rename.nvim"
   "mfussenegger/nvim-dap"
   "ldelossa/nvim-dap-projects"
   "theHamsta/nvim-dap-virtual-text"
   (_ "rcarriga/nvim-dap-ui" 
      {:dependencies 
         ["mfussenegger/nvim-dap"
          "nvim-neotest/nvim-nio"]})
   "folke/lsp-colors.nvim"
   "folke/trouble.nvim"
   "lukas-reineke/lsp-format.nvim"

   ;; Completion
   (_ "ms-jpq/coq_nvim"
      {:branch "coq"
       :lazy false
       :dependencies
        [(_ "ms-jpq/coq.artifacts" {:branch "artifacts"})]
       :build ":COQdeps"
       :init #(tset vim.g :coq_settings {:auto_start true})})
   "github/copilot.vim"

   ;; Key Bindings
   "tpope/vim-commentary"
   (_ "folke/which-key.nvim"
      {:opts {:notify false}})
   "ggandor/leap.nvim"
   (_ "kethku/dock_nvim"
      {:dir "c:/dev/Projects/dock_nvim"})])
