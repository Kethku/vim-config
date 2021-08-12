(module module.bindings
  {require {nvim aniseed.nvim
            core aniseed.core
            util util}})

;; Utils ;;
;;;;;;;;;;;

(defn- map [mode from to]
  "Sets a mapping"
  (nvim.set_keymap mode from to {}))

(defn- map-silent [mode from to]
  "Sets a mapping with {:silent true}"
  (nvim.set_keymap mode from to {:silent true}))

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}"
  (nvim.set_keymap mode from to {:noremap true}))

(defn- noremap-silent [mode from to]
  "Sets a mapping with {:noremap true :silent true}"
  (nvim.set_keymap mode from to {:noremap true :silent true}))

(defn- declare-command [body]
  (nvim.command (.. "command! " body)))

(defn- declare-command-with-args [body]
  (nvim.command (.. "command! -nargs=+ " body)))

(defn- is-terminal-buffer [bufnumber]
  (and (= (. nvim.bo bufnumber "buftype") "terminal") 
       (= (. nvim.b bufnumber "floaterm_window") 1)))

(defn- is-terminal-window [winnr]
  (is-terminal-buffer (nvim.fn.winbufnr winnr)))

(defn- find-terminal-window []
  (core.first 
    (core.filter 
      is-terminal-window
      (nvim.fn.range 1 (nvim.fn.winnr "$")))))
(util.export :find_terminal_window find-terminal-window)

(defn hide-terminal []
  (let [winnr (find-terminal-window)]
    (if (not (core.nil? winnr))
      (nvim.command (.. winnr " wincmd q")))))
(util.export :hide_terminal hide-terminal)

(defn setup-terminal []
  (tset nvim.g "floaterm_width" (- (. nvim.o "columns") 10))
  (tset nvim.g "floaterm_height" (- (. nvim.o "lines") 5)))

(defn toggle-terminal []
  (setup-terminal)
  (set nvim.o.shell "pwsh")
  (nvim.ex.FloatermToggle)
  (set nvim.o.shell "cmd"))
(util.export :toggle_terminal toggle-terminal)

(defn new-terminal []
  (setup-terminal)
  (set nvim.o.shell "pwsh")
  (nvim.ex.FloatermNew)
  (set nvim.o.shell "cmd"))
(util.export :new_terminal new-terminal)

(defn next-terminal []
  (setup-terminal)
  (nvim.ex.FloatermNext))
(util.export :next_terminal next-terminal)

(defn previous-terminal []
  (setup-terminal)
  (nvim.ex.FloatermPrev))
(util.export :previous_terminal previous-terminal)

(defn okeydokey [args]
  (nvim.command (.. "!pwsh -Command ok " args)))
(util.export :okeydokey okeydokey)

(defn okeydokey-loc [args]
  (nvim.command 
    (.. "!pwsh -Command ok " args 
        (nvim.ex.resolve "%:p") " " 
        (nvim.ex.line ".") " " 
        (nvim.ex.col "."))))
(util.export :okeydokey_loc okeydokey-loc)

(declare-command-with-args "Ok call v:lua.g.okeydokey(<q-args>)")
(declare-command-with-args "OkLoc call v:lua.g.okeydokey_loc(<q-args>)")

;; LEADER ;;
;;;;;;;;;;;;

(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")
(noremap-silent :n :<leader> ":<c-u>WhichKey '<Space>'<CR>")
(noremap-silent :v :<leader> ":<c-u>WhichKeyVisual '<Space>'<CR>")

(global which_key_map {})

(defn define-category [keys documentation]
    (tset (core.get-in which_key_map (core.butlast keys) nil) (core.last keys) {:name documentation}))

(defn- concat [a b] (.. a b))

(defn define-binding [mode keys documentation body]
  (tset (core.get-in which_key_map (core.butlast keys)) (core.last keys) documentation)
  (noremap-silent mode (core.reduce concat "<leader>" keys) body))

(define-category [:v] "+vim")
(define-binding :n [:v :i] "install" ":luafile $MYVIMRC<CR>:PaqInstall<CR>")
(define-binding :n [:v :u] "update" ":luafile $MYVIMRC<CR>:PaqUpdate<CR>")
(define-binding :n [:v :c] "clean unused" ":luafile $MYVIMRC<CR>:PaqClean<CR>")
(define-category [:v :e] "+edit")
(define-binding :n [:v :e :B] "init.lua (bootstrap)" ":e $MYVIMRC<CR>")
(define-binding :n [:v :e :i] "init.fnl" ":e $MYVIMRC/../fnl/init.fnl<CR>")
(define-binding :n [:v :e :b] "bindings.fnl" ":e $MYVIMRC/../fnl/module/bindings.fnl<CR>")
(define-binding :n [:v :e :p] "plugins.fnl" ":e $MYVIMRC/../fnl/module/plugins.fnl<CR>")
(define-binding :n [:v :e :s] "settings.fnl" ":e $MYVIMRC/../fnl/module/settings.fnl<CR>")
(define-binding :n [:v :e :l] "lsp.fnl" ":e $MYVIMRC/../fnl/module/lsp.fnl<CR>")

(define-category [:q] "+quit")
(define-binding :n [:q :q] "quit and save everything" ":wqall<CR>")
(define-binding :n [:q :r] "quit and reload" ":Obsession ~/session.vim<CR>:!start neovide -S ~/session.vim<CR><CR>:wqall<CR>")

(define-category [:w] "+windows")
(define-binding :n [:w :h] "jump left" "<C-w>h")
(define-binding :n [:w :j] "jump down" "<C-w>j")
(define-binding :n [:w :k] "jump up" "<C-w>k")
(define-binding :n [:w :l] "jump right" "<C-w>l")
(define-binding :n [:w :y] "split left" ":vsplit<CR><ESC>")
(define-binding :n [:w :u] "split down" ":split<CR><C-w>j<ESC>")
(define-binding :n [:w :i] "split up" ":split<CR><ESC>")
(define-binding :n [:w :o] "split right" ":vsplit<CR><C-w>l<ESC>")
(define-binding :n [:w :=] "auto resize" "<Plug>(golden_ratio_resize)")

(define-category [:b] "+buffers")
(define-binding :n [:b :b] "buffers" ":Buffers<CR>")
(define-binding :n [:b :h] "previous" ":bprevious<CR>")
(define-binding :n [:b :l] "next" ":bnext<CR>")
(define-binding :n [:b :k] "first" ":bfirst<CR>")
(define-binding :n [:b :j] "last" ":blast<CR>")
(define-binding :n [:b :d] "delete" ":BD<CR>")

(define-category [:f] "+file")
(define-binding :n [:f :r] "recent" ":lua require'telescope.builtin'.oldfiles{}<CR>")
(define-binding :n [:f :s] "save" ":w<CR>")

(define-category [:k] "+kill")
(define-binding :n [:k :w] "window" ":wq<CR>")

(define-category [:t] "+terminal")
(define-binding :n [:t :t] "Open Terminal" "<ESC>:call v:lua.g.toggle_terminal()<CR>")
(define-binding :n [:t :n] "New Terminal" "<ESC>:call v:lua.g.new_terminal()<CR>")
(define-binding :n [:t :l] "Next Terminal" "<ESC>:call v:lua.g.next_terminal()<CR>")
(define-binding :n [:t :h] "Previous Terminal" "<ESC>:call v:lua.g.previous_terminal()<CR>")

(define-category [";"] "+commentary")
(define-binding :n [";" ";"] "current line" ":Commentary<CR>")

(set nvim.g.which_key_map which_key_map)

;; (nvim.call_function "which_key#register" ["<Space>" "g:which_key_map"])

;;  LSP  ;;
;;;;;;;;;;;

(noremap-silent :n "gh" ":lua vim.lsp.buf.hover()<CR>")
(noremap-silent :n "gd" ":lua vim.lsp.buf.definition()<CR>")
(map-silent :n "<C-.>" ":lua vim.lsp.buf.code_action()<CR>")
(map-silent :v "<C-.>" ":lua vim.lsp.buf.code_action()<CR>")

;; VISUAL ;;
;;;;;;;;;;;;

(noremap-silent :v "<" "<gv")
(noremap-silent :v ">" ">gv")
(noremap-silent :v ";" ":Commentary<CR>")
(noremap-silent :v "<M-q>" "gq")

;; TERMINAL ;;
;;;;;;;;;;;;;;

(noremap-silent :t "<ESC>" "<C-\\><C-n>")

;; SCROLLING ;;
;;;;;;;;;;;;;;;

(noremap-silent :n "<down>" ":call comfortable_motion#flick(100)<CR>")
(noremap-silent :n "<up>" ":call comfortable_motion#flick(-100)<CR>")

;; GENERAL ;;
;;;;;;;;;;;;;

(noremap-silent :n "-" ":Balsamic<CR>")
(map-silent :n "<ESC>" ":noh<CR>:call v:lua.g.hide_terminal()<CR>")

(core.run! 
  (lambda [mode] (map-silent mode "fd" "<Esc>"))
  [:n :i :t :c :v])
