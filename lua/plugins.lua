return require("lazy").setup({
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    {
        "rebelot/kanagawa.nvim",
        opts = {
            compile = true,
            dimInactive = false
        }
    },
    "ryanoasis/vim-devicons",
    "nvim-lualine/lualine.nvim",
    "kyazdani42/nvim-web-devicons",
    "romgrk/barbar.nvim",
    "lewis6991/satellite.nvim",
    "ellisonleao/gruvbox.nvim",
    {
        "olical/nfnl",
        ft = "fennel"
    },
    "tpope/vim-sleuth",
    {
        "voldikss/vim-floaterm",
        lazy = false
    },
    "kethku/golden-ratio",
    "yuttie/comfortable-motion.vim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-frecency.nvim",
    "nvim-telescope/telescope-project.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
        "j-hui/fidget.nvim",
        branch = "legacy"
    },
    "glepnir/lspsaga.nvim",
    "smjonas/inc-rename.nvim",
    "mfussenegger/nvim-dap",
    "ldelossa/nvim-dap-projects",
    "theHamsta/nvim-dap-virtual-text",
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
    },
    "folke/lsp-colors.nvim",
    "folke/trouble.nvim",
    "lukas-reineke/lsp-format.nvim",
    {
        "ms-jpq/coq_nvim",
        branch = "coq",
        dependencies = {
            "ms-jpq/coq.artifacts",
            branch = "artifacts"
        },
        build = ":COQdeps",
        init = function()
            vim.g["coq_settings"] = { auto_start = true }
        end,
        lazy = false
    },
    "github/copilot.vim",
    "tpope/vim-commentary",
    {
        "folke/which-key.nvim",
        opts = { notify = false }
    },
    "ggandor/leap.nvim",
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        }
    }
})
