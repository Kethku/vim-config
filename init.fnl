(local req (. (require "util") "safe-require"))

(local execute vim.api.nvim_command)

(let [lazypath (.. (vim.fn.stdpath "data") "/lazy/lazy.nvim")
      fs-stat (. (or vim.uv vim.loop) "fs_stat")
      needs_cloned (not (fs-stat lazypath))]
  (if needs_cloned
      (let [git-output (vim.fn.system
                          ["git"
                           "clone"
                           "--filter=blob:none"
                           "https://github.com/folke/lazy.nvim.git"
                           "--branch=stable"
                           lazypath])]
        (print git-output)))
  (vim.opt.rtp:prepend lazypath))

(req "plugins")
(req "settings")
(req "lsp")
(req "treesitter")
(req "bindings")
(req "resize")

{}
