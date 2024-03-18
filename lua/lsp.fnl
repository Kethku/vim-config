(local config (require "lspconfig"))
(local mason (require "mason"))
(local masonLspconfig (require "mason-lspconfig"))
(local fidget (require "fidget"))
(local lspsaga (require "lspsaga"))
(local watchfiles (require "vim.lsp._watchfiles"))
(local lsp-format (require "lsp-format"))

(local dap (require "dap"))
(local dap-projects (require "nvim-dap-projects"))
(local nvim-dap-virtual-text (require "nvim-dap-virtual-text"))
(local dap-ui (require "dapui"))

(mason.setup)
(masonLspconfig.setup)
(lsp-format.setup)

(config.tsserver.setup 
  {:on_attach lsp-format.on_attach})
(config.omnisharp.setup 
  {:on_attach lsp-format.on_attach})
(config.gdscript.setup 
  {:cmd ["ncat" "localhost" "6005"]
   :flags {:debounce_text_changes 500}
   :on_attach lsp-format.on_attach})
(config.rust_analyzer.setup 
  {:on_attach lsp-format.on_attach})
(config.lua_ls.setup 
  {:on_attach lsp-format.on_attach})

(fidget.setup 
  {})
(lspsaga.setup 
  {:ui {:border "none"
        :winblend 50}
   :symbol_in_winbar {:enable false}
   :lightbulb {:enable false}
   :outline {:win_position "float"
             :close_after_jump true}})

(tset watchfiles :_watchfunc (lambda [_ _ _] true))

(tset dap.defaults.fallback :exception_breakpoints ["rust_panic"])
(dap-projects.search_project_config)
(nvim-dap-virtual-text.setup)
(dap-ui.setup)

(vim.fn.sign_define "DapBreakpoint"
  {:text "🔴"
   :texthl "DapBreakpointSymbol"
   :linehl "DapBreakpoint"
   :numhl "DapBreakpoint"})

(vim.diagnostic.config 
  {:update_in_insert false})
