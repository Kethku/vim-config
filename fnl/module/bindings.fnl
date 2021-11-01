(module module.bindings
  {require {nvim     aniseed.nvim
            core     aniseed.core
            util     util
            whichkey "which-key"}})

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

(defn- noremap-silent-expr [mode from to]
  "Sets a mapping with {:noremap true :silent true :expr true}"
  (nvim.set_keymap mode from to {:noremap true :silent true :expr true}))

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

(whichkey.register
  {:v {:name "Vim"
       :i [":luafile $MYVIMRC<CR>:PaqInstall<CR>" "install"]
       :u [":luafile $MYVIMRC<CR>:PaqUpdate<CR>" "update"]
       :c [":luafile $MYVIMRC<CR>:PaqClean<CR>" "clean unused"]
       :e {:name "Edit"
           :I [":e $MYVIMRC<CR>" "init.lua (bootstrap)"]
           :i [":e $MYVIMRC/../fnl/init.fnl<CR>" "init.fnl"]
           :b [":e $MYVIMRC/../fnl/module/bindings.fnl<CR>" "bindings.fnl"]
           :p [":e $MYVIMRC/../fnl/module/plugins.fnl<CR>" "plugins.fnl"]
           :s [":e $MYVIMRC/../fnl/module/settings.fnl<CR>" "settings.fnl"]
           :l [":e $MYVIMRC/../fnl/module/lsp.fnl<CR>" "lsp.fnl"]}}
   :q {:name "Quit"
       :q [":wqall<CR>" "quit and save everything"]
       :r [":Obsession ~/session.vim<CR>:!start neovide -S ~/session.vim<CR><CR>:wqall<CR>" "quit and reload"]}
   :w {:name "Windows"
       :h ["<C-w>h" "jump left"]
       :j ["<C-w>j" "jump down"]
       :k ["<C-w>k" "jump up"]
       :l ["<C-w>l" "jump right"]
       :y [":vsplit<CR><ESC>" "split left"]
       :u [":split<CR><C-w>j<ESC>" "split down"]
       :i [":split<CR><ESC>" "split up"]
       :o [":vsplit<CR><C-w>l<ESC>" "split right"]
       := ["<Plug>(golden_ratio_resize)" "auto resize"]}
   :b {:name "Buffers"
       :b [":Buffers<CR>" "buffers"]
       :h [":bprevious<CR>" "previous"]
       :l [":bnext<CR>" "next"]
       :k [":bfirst<CR>" "first"]
       :j [":blast<CR>" "last"]
       :d [":BD<CR>" "delete"]}
   :f {:name "Files"
       :r [":lua require'telescope.builtin'.oldfiles{}<CR>" "recent"]
       :s [":w<CR>" "save"]}
   :t {:name "Terminal"
       :t ["<ESC>:call v:lua.g.toggle_terminal()<CR>" "Open Terminal"]
       :n ["<ESC>:call v:lua.g.new_terminal()<CR>" "New Terminal"]
       :l ["<ESC>:call v:lua.g.next_terminal()<CR>" "Next Terminal"]
       :h ["<ESC>:call v:lua.g.previous_terminal()<CR>" "Previous Terminal"]}
   ";" {:name "Comments"
       ";" [":Commentary<CR>" "current line"]}}
  {:prefix "<leader>"})

;;  LSP  ;;
;;;;;;;;;;;

(noremap-silent :n "gh" ":lua vim.lsp.buf.hover()<CR>")
(noremap-silent :n "gd" ":lua vim.lsp.buf.definition()<CR>")
(map-silent :n "<C-.>" ":lua vim.lsp.buf.code_action()<CR>")
(map-silent :v "<C-.>" ":lua vim.lsp.buf.code_action()<CR>")

;; COQ ;;
;;;;;;;;;

(set vim.g.coq_settings
     {:keymap.recommended false})

(noremap-silent-expr :i "<Esc>" "pumvisible() ? '<C-e><Esc>' : '<Esc>'")
(noremap-silent-expr :i "<C-c>" "pumvisible() ? '<C-e><C-c>' : '<C-c>'")
(noremap-silent-expr :i "<BS>" "pumvisible() ? '<C-e><BS>' : '<BS>'")
; (noremap-silent-expr :i "<cr>" "pumvisible() ? (complete_info().selected == -1 ? '<C-e><CR>' : '<C-y>') : '<CR>'")
(noremap-silent-expr :i "<Down>" "pumvisible() ? '<C-n>' : '<Down>'")
(noremap-silent-expr :i "<Up>" "pumvisible() ? '<C-p>' : '<Up>'")

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
