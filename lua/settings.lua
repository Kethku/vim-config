-- [nfnl] Compiled from lua/settings.fnl by https://github.com/Olical/nfnl, do not edit.
local lualine = require("lualine")
local satellite = require("satellite")
local telescope = require("telescope")
local autocmd = vim.api.nvim_create_autocmd
local util = require("util")
vim.cmd("filetype plugin indent on")
vim.cmd("autocmd BufEnter * silent! lcd &:p:h")
vim.cmd("autocmd FileType markdown setlocal spell")
vim.cmd("autocmd FileType markdown set textwidth=60")
vim.cmd("autocmd BufWritePre * silent! lua vim.lsp.buf.format()")
lualine.setup({options = {icons_enabled = true, theme = "auto", component_separators = {left = "\238\130\181", right = "\238\130\183"}, section_separators = {left = "\238\130\180", right = "\238\130\182"}, always_divide_middle = true}, sections = {lualine_a = {"mode"}, lualine_b = {"branch", "diff", "diagnostics"}, lualine_c = {"filename"}, lualine_x = {"encoding", "fileformat", "filetype"}, lualine_y = {"progress"}, lualine_z = {"location"}}, inactive_sections = {lualine_a = {}, lualine_b = {}, lualine_c = {"filename"}, lualine_x = {"location"}, lualine_y = {}, lualine_z = {}}})
vim.g.markdown_fenced_languages = {"javascript", "typescript", "js=javascript"}
vim.g.vim_markdown_folding_disabled = 1
vim.g.gruvbox_invert_selection = 1
vim.cmd("colorscheme gruvbox")
vim.cmd("autocmd FileType floaterm setlocal winblend=10")
vim.g.floaterm_position = "center"
vim.g.floaterm_shell = "pwsh"
telescope.load_extension("project")
vim.g.neovide_refresh_rate = 60
vim.g.neovide_scroll_animation_length = 0.2
vim.g.neovide_remember_window_size = true
satellite.setup({width = 0})
vim.g.coq_settings = {auto_start = "shut-up"}
vim.o.winblend = 20
vim.o.pumblend = 20
vim.o.ve = "block"
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.timeoutlen = 500
vim.o.textwidth = 120
vim.o.conceallevel = 3
vim.o.signcolumn = "no"
vim.o.laststatus = 3
vim.o.number = false
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmode = false
vim.o.hidden = true
vim.o.wrap = false
vim.o.splitkeep = "screen"
vim.o.mousemodel = "extend"
return nil
