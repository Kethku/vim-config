(module dotfiles.module.bindings
  {require {nvim aniseed.nvim
            core aniseed.core}})

;; Utils ;;
;;;;;;;;;;;

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}"
  (nvim.set_keymap mode from to {:noremap true}))

(defn- noremap-silent [mode from to]
  "Sets a mapping with {:noremap true :silent true}"
  (nvim.set_keymap mode from to {:noremap true :silent true}))

(defn- is-terminal-window [bufnumber]
  (and (= (. nvim.bo bufnumber "buftype") "terminal") 
       (= (. nvim.b bufnumber "floaterm_window") 1)))

(defn- find-terminal-window []
  (core.first 
    (core.filter 
      is-terminal-window 
      (nvim.fn.range 1 (nvim.fn.winnr "$")))))

(defn hide-terminal []
  (let [winnr (find-terminal-window)]
    (if (> winnr 0)
      (nvim.command (.. winnr "wincmd q")))))

(defn setup-terminal []
  (tset nvim.g "floaterm_width" (- (. nvim.o "columns") 10))
  (tset nvim.g "floaterm_height" (- (. nvim.o "lines") 5)))

(defn toggle-terminal []
  (setup-terminal)
  (set nvim.o.shell "pwsh")
  (nvim.ex.FloatermToggle)
  (set nvim.o.shell "cmd"))

(defn new-terminal []
  (setup-terminal)
  (set nvim.o.shell "pwsh")
  (nvim.ex.FloatermNew)
  (set nvim.o.shell "cmd"))

(defn next-terminal []
  (setup-terminal)
  (nvim.ex.FloatermNext))

(defn previous-terminal []
  (setup-terminal)
  (nvim.ex.FloatermPrev))

;; LEADER ;;
;;;;;;;;;;;;

; (set nvim.g.mapleader "\\<Space>")
; (noremap-silent :n :<leader> ":<c-u>WhichKey '<Space>'<CR>")
; (noremap-silent :v :<leader> ":<c-u>WhichKeyVisual '<Space>'<CR>")

; (set nvim.g.which_key_map {})

; (set nvim.g.which_key_map.v {:name "+vim"})
