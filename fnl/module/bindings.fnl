(module module.bindings
  {require {nvim     aniseed.nvim
            core     aniseed.core
            util     util
            whichkey "which-key"}})

;; Utils ;;
;;;;;;;;;;;

(def- windows? (= (nvim.fn.has "win32") 1))

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

(defn hide-terminal []
  (nvim.ex.FloatermHide))
(util.export :hide_terminal hide-terminal)

(defn setup-terminal []
  (tset nvim.g "floaterm_width" (- (. nvim.o "columns") 10))
  (tset nvim.g "floaterm_height" (- (. nvim.o "lines") 5)))

(defn toggle-terminal []
  (setup-terminal)
  (nvim.ex.FloatermToggle))
(util.export :toggle_terminal toggle-terminal)

(defn new-terminal []
  (setup-terminal)
  (nvim.ex.FloatermNew))
(util.export :new_terminal new-terminal)

(defn next-terminal []
  (setup-terminal)
  (nvim.ex.FloatermNext))
(util.export :next_terminal next-terminal)

(defn previous-terminal []
  (setup-terminal)
  (nvim.ex.FloatermPrev))
(util.export :previous_terminal previous-terminal)

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
           :I [(.. ":e " (nvim.fn.stdpath "config") "/init.lua<CR>") "init.lua (bootstrap)"]
           :i [(.. ":e " (nvim.fn.stdpath "config") "/fnl/init.fnl<CR>") "init.fnl"]
           :b [(.. ":e " (nvim.fn.stdpath "config") "/fnl/module/bindings.fnl<CR>") "bindings.fnl"]
           :p [(.. ":e " (nvim.fn.stdpath "config") "/fnl/module/plugins.fnl<CR>") "plugins.fnl"]
           :s [(.. ":e " (nvim.fn.stdpath "config") "/fnl/module/settings.fnl<CR>") "settings.fnl"]
           :l [(.. ":e " (nvim.fn.stdpath "config") "/fnl/module/lsp.fnl<CR>") "lsp.fnl"]
           :t [(.. ":e " (nvim.fn.stdpath "config") "/fnl/module/treesitter.fnl<CR>") "treesitter.fnl"]}}
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
       ";" [":Commentary<CR>" "current line"]}
   "l" {:name "LSP"
        :h ["<cmd>Lspsaga hover_doc<CR>" "Hover"]
        :H ["<cmd>Lspsaga <cmd>Lspsaga show_cursor_diagnostics<CR>"]
        :d ["<cmd>Lspsaga preview_definition<CR>" "Preview Definition"]
        :D ["<cmd>Lspsaga goto_definition<CR>" "Goto Definition"]
        :r ["<cmd>Lspsaga rename<CR>" "Rename"]
        :. ["<cmd>Lspsaga code_action<CR>" "Code Action"]
        :n ["<cmd>Lspsaga diagnostic_jump_next<CR>" "Next Diagnostic"]
        :p ["<cmd>Lspsaga diagnostic_jump_prev<CR>" "Previous Diagnostic"]}}
  {:prefix "<leader>"})

;; COQ ;;
;;;;;;;;;

(set vim.g.coq_settings
     {:keymap.recommended false})

(noremap-silent-expr :i "<Esc>" "pumvisible() ? '<C-e><Esc>' : '<Esc>'")
(noremap-silent-expr :i "<C-c>" "pumvisible() ? '<C-e><C-c>' : '<C-c>'")
(noremap-silent-expr :i "<BS>" "pumvisible() ? '<C-e><BS>' : '<BS>'")
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

(map-silent :n "<ESC>" ":noh<CR>:call v:lua.g.hide_terminal()<CR>")
