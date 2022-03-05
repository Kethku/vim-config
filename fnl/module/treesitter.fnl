(module module.treesitter
  {require {parsers nvim-treesitter.parsers
            configs nvim-treesitter.configs}})

(vim.cmd "au BufRead,BufNewFile *.wgsl set filetype=wgsl")

(def- parser_config (parsers.get_parser_configs))

(set parser_config.wgsl 
     {:install_info {:url "https://github.com/szebniok/tree-sitter-wgsl"
                     :files ["src/parser.c"]}})

(configs.setup {:ensure_installed ["wgsl"]
                :highlight {:enabled true}})
