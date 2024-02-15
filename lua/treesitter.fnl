(local parsers (require "nvim-treesitter.parsers"))
(local configs (require "nvim-treesitter.configs"))

(local parser_config (parsers.get_parser_configs))

(configs.setup 
  {:ensure_installed 
   ["fennel" "rust" "lua" "markdown" "markdown_inline" "gdscript"]
   :highlight {:enable true}})
