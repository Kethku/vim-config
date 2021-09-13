(module init
  {require {util util}})

(def req util.safe-require)

(req "module.plugins")
(req "module.settings")
(req "module.bindings")
(req "module.lsp")
