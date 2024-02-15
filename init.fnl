(local req (. (require "util") "safe-require"))

(set vim.o.shellslash true)

(local execute vim.api.nvim_command)

(local install_path (.. (vim.fn.stdpath "data") "/site/pack/paqs/opt/paq-nvim"))
(if (> (vim.fn.empty (vim.fn.glob install_path)) 0)
  (vim.fn.system {"git" "clone" "https://github.com/savq/paq-nvim" install_path}))

(execute "packadd paq-nvim")

(req "plugins")
(req "settings")
(req "lsp")
(req "treesitter")
(req "bindings")
(req "resize")

{}
