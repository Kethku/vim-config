-- [nfnl] Compiled from fnl/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local install = require("nvim-treesitter.install")
local parsers = require("nvim-treesitter.parsers")
local configs = require("nvim-treesitter.configs")
local parser_config = parsers.get_parser_configs()

install.compilers = { "clang", "gcc" }
return configs.setup({ ensure_installed = { "fennel", "rust", "lua", "markdown", "markdown_inline", "gdscript" }, highlight = { enable = true } })
