(module module.lsp
  {require {config lspconfig
            mason mason
            masonLspconfig mason-lspconfig
            rt rust-tools}})

(mason.setup)
(masonLspconfig.setup)
(rt.setup {})

(config.tsserver.setup {})
