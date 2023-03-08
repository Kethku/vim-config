(module module.treesitter
  {require {parsers nvim-treesitter.parsers
            configs nvim-treesitter.configs}})

(def- parser_config (parsers.get_parser_configs))

(configs.setup {:ensure_installed ["fennel" "rust" "lua"]
                :highlight {:enabled true}})
