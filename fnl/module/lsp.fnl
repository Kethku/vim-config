(module module.lsp
  {require {compe  compe
            config lspconfig}})

(tset vim.o :completeopt "menuone,noselect")
(compe.setup 
  {
   :enabled          true
   :autocomplete     true
   :debug            false
   :min_length       1
   :preselect        "always"
   :throttle_time    80
   :source_timeout   200
   :incomplete_delay 400
   :max_abbr_width   100
   :max_kind_width   100
   :max_menu_width   100
   :documentation    true
   :source 
   {
    :path     true
    :buffer   true
    :calc     true
    :nvim_lsp true
    :nvim_lua true
    :conjure  true
   }
  })

(config.rust_analyzer.setup {})
(config.tsserver.setup {})
