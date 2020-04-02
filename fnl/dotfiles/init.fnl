(module dotfiles.init
  {require {core aniseed.core
            mapping aniseed.mapping
            util dotfiles.util}})

(->> (util.glob (.. util.config-path "/lua/dotfiles/module/*.lua"))
     (core.run! (fn [path]
                  (require (string.gsub path ".*\\(.-)\\(.-)\\(.-)%.lua" "%1.%2.%3")))))

(mapping.init)
