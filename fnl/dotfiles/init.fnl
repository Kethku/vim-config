(module dotfiles.init
  {require {nvim aniseed.nvim
            core aniseed.core
            util dotfiles.util}})

(->> (util.glob (.. util.config-path "/lua/dotfiles/module/*.lua"))
     (core.run! (fn [path]
                  (require (string.gsub path ".*\\(.-)\\(.-)\\(.-)%.lua" "%1.%2.%3")))))
