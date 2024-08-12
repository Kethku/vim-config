-- [nfnl] Compiled from fnl\plugins.fnl by https://github.com/Olical/nfnl, do not edit.
local lazy = require("lazy")
local function _(pkg, config)
  local result = vim.deepcopy(config)
  do end (result)[1] = pkg
  return result
end
local function _1_()
  vim.g["coq_settings"] = {auto_start = true}
  return nil
end
return lazy.setup({"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", _("rebelot/kanagawa.nvim", {opts = {compile = true, dimInactive = false}}), "ryanoasis/vim-devicons", "nvim-lualine/lualine.nvim", "kyazdani42/nvim-web-devicons", "romgrk/barbar.nvim", "lewis6991/satellite.nvim", "ellisonleao/gruvbox.nvim", _("olical/nfnl", {ft = "fennel"}), "tpope/vim-sleuth", _("voldikss/vim-floaterm", {lazy = false}), "kethku/golden-ratio", "yuttie/comfortable-motion.vim", "nvim-treesitter/nvim-treesitter", "nvim-telescope/telescope.nvim", "nvim-telescope/telescope-frecency.nvim", "nvim-telescope/telescope-project.nvim", "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig", _("j-hui/fidget.nvim", {branch = "legacy"}), "glepnir/lspsaga.nvim", "smjonas/inc-rename.nvim", "mfussenegger/nvim-dap", "ldelossa/nvim-dap-projects", "theHamsta/nvim-dap-virtual-text", _("rcarriga/nvim-dap-ui", {dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}}), "folke/lsp-colors.nvim", "folke/trouble.nvim", "lukas-reineke/lsp-format.nvim", _("ms-jpq/coq_nvim", {branch = "coq", dependencies = {_("ms-jpq/coq.artifacts", {branch = "artifacts"})}, build = ":COQdeps", init = _1_, lazy = false}), "github/copilot.vim", "tpope/vim-commentary", _("folke/which-key.nvim", {opts = {notify = false}}), "ggandor/leap.nvim", _("kethku/dock_nvim", {dir = "c:/dev/Projects/dock_nvim"})})
