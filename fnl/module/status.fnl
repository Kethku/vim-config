(module module.status
  {require {bl bufferline
            gl galaxyline}})

(bl.setup)

(def- gls gl.section)

(def- colors 
  {:bg "#282828"
   :fg "#ebdbb2"
   :red "#cc241d"
   :green "#98971a"
   :yellow "#d79921"
   :blue "#458588"
   :purple "#b16286"
   :aqua "#689d6a"
   :orange "#d65d0e"
   :gray "#a89984"})

(tset gls.left 2
      {:ViMode {:provider (fn [] (vim.fn.mode))
                :highlight "Visual"}})

(tset gls.left 4
      {:FileName {:provider "FileName"
                  :highlight "StatusLine"}})
