(local Util {})

(fn Util.safe-require [name]
  (let [(ok? val-or-err) (pcall require name)]
    (when (not ok?)
      (print (.. "Plugin error from " name ": " val-or-err)))))

(global g {})

(fn Util.export [name variable]
  (tset g name variable))

(fn Util.set-option [option]
  (vim.cmd (.. "set " option)))

(fn Util.declare-command [body]
  (vim.api.nvim_command (.. "command! " body)))

(fn Util.declare-command-with-args [body]
  (vim.api.nvim_command (.. "command! -nargs=+ " body)))

(fn Util.contains? [xs x]
  (let [found false]
    (each [_ value (pairs xs) &until found]
      (when (= value x)
        (table.insert found true)))
    found))

Util
