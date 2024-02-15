-- [nfnl] Compiled from lua/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local parsers = require("nvim-treesitter.parsers")
local configs = require("nvim-treesitter.configs")
local parser_config = parsers.get_parser_configs()
return configs.setup({ensure_installed = {"fennel", "rust", "lua", "markdown", "markdown_inline", "gdscript"}, highlight = {enable = true}})
