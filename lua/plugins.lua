return require("lazy").setup({
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "ryanoasis/vim-devicons",
    "jakemason/ouroboros",
    "nvim-lualine/lualine.nvim",
    "kyazdani42/nvim-web-devicons",
    "akinsho/bufferline.nvim", 
    {
        "rebelot/kanagawa.nvim",
        opts = {
            theme = "dragon",
            overrides = function(colors)
                local theme = colors.theme
                return {
                    Floaterm = { bg = theme.ui.bg_dim },
                }
            end,
        },
        config = function()
            vim.cmd([[colorscheme kanagawa]])
        end,
        lazy = false
    },
    "tpope/vim-sleuth",
    {
        "voldikss/vim-floaterm",
        lazy = false
    },
    "yuttie/comfortable-motion.vim",
    "nvim-telescope/telescope.nvim",
    {
        "nvim-telescope/telescope-frecency.nvim",
        opts = {
            db_safe_mode = false,
        }
    },
    "nvim-telescope/telescope-project.nvim",
    "williamboman/mason.nvim",
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            { "ms-jpq/coq_nvim", branch = "coq" },
            { "ms-jpq/coq.artifacts", branch = "artifacts" },
            { 'ms-jpq/coq.thirdparty', branch = "3p" }
        },
        init = function()
            vim.g.coq_settings = { auto_start = "shut-up" }
        end,
    },
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
    { 
        "nvim-telescope/telescope-dap.nvim",
        dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" } 
    },
    "folke/lsp-colors.nvim",
    "klen/nvim-config-local",
    "folke/trouble.nvim",
    "lukas-reineke/lsp-format.nvim",
    "github/copilot.vim",
    "tpope/vim-commentary",
    {
        "folke/which-key.nvim",
        opts = { notify = false }
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        }
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            }
        }
    },
    {
        'stevearc/oil.nvim',
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
        lazy = false,
    },
    {
        'kwkarlwang/bufresize.nvim',
        opts = {
            register = {
                trigger_events = { 'BufWinEnter', 'WinEnter', 'WinResized' },
            },
            resize = {
                keys = {},
                trigger_events = { 'VimResized' },
                increment = false,
            },
        },
    },
    { 
        "tadmccorkle/markdown.nvim",
        config = function()
            require("markdown").setup()
        end,
    },
    "NeogitOrg/neogit",
    {
        'chomosuke/term-edit.nvim',
        event = 'TermOpen',
        version = '1.*',
    }
})
