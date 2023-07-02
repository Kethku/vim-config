(module module.lsp
  {require {config lspconfig
            mason mason
            masonLspconfig mason-lspconfig
            rt rust-tools
            fidget fidget
            lspsaga lspsaga}})

(mason.setup)
(masonLspconfig.setup)
(rt.setup {})

(config.tsserver.setup {})

(fidget.setup 
  {})
(lspsaga.setup 
  {:ui {:border "shadow"
        :winblend 50}
   :symbol_in_winbar {:enable false}
   :lightbulb {:enable false}})
