(module util
  {require {nvim aniseed.nvim}})

(defn expand [path]
  (nvim.fn.expand path))

(defn glob [path]
  (nvim.fn.glob path true true true))

(defn exists? [path]
  (= (nvim.fn.filereadable path) 1))

(def config-path (nvim.fn.stdpath "config"))

(global g {})

(defn export [name function]
  (tset g name function))

(defn number? [x]
  (= "number" (type x)))

(defn safe-equal [x y] (and (= (type x) (type y)) (= x y)))

(defn safe-not-equal [x y] (or (not= (type x) (type y)) (not= x y)))

(defn safe-require [name]
  (let [(ok? val-or-err) (pcall require name)]
    (when (not ok?)
      (print (.. "Plugin error from " name ": " val-or-err)))))

