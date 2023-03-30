(module module.lsp
  {require {config lspconfig
            mason mason
            masonLspconfig mason-lspconfig
            rt rust-tools
            fidget fidget
            lspsaga lspsaga
            inc_rename inc_rename}})

(mason.setup)
(masonLspconfig.setup)
(rt.setup {})

(config.tsserver.setup {})

(fidget.setup {})
(lspsaga.setup {})
(inc_rename.setup {})
