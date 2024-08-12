(require "nvim-treesitter")
(local parsers (require "nvim-treesitter.parsers"))
(local configs (require "nvim-treesitter.configs"))

(local parser_config (parsers.get_parser_configs))

(configs.setup 
  {:ensure_installed 
   ["fennel" "rust" "lua" "markdown" "markdown_inline" "gdscript" "glsl" "wgsl"]
   :highlight {:enable true}})
(vim.treesitter.language.register "glsl" "frag")
(vim.treesitter.language.register "glsl" "vert")
(vim.treesitter.language.register "wgsl" "wfrag")
(vim.treesitter.language.register "wgsl" "wvert")

(vim.filetype.add
  {:extension {:wfrag :wgsl :wvert :wgsl}})
