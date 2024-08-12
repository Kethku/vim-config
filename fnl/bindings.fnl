(local util (require "util"))
(local whichkey (require "which-key"))
(local leap (require "leap"))

;; UTILS ;;
;;;;;;;;;;;

(fn map [mode from to]
  "Sets a mapping"
  (vim.api.nvim_set_keymap mode from to {}))

(fn map-silent [mode from to]
  "Sets a mapping with {:silent true}"
  (vim.api.nvim_set_keymap mode from to {:silent true}))

(fn noremap [mode from to]
  "Sets a mapping with {:noremap true}"
  (vim.api.nvim_set_keymap mode from to {:noremap true}))

(fn noremap-silent [mode from to]
  "Sets a mapping with {:noremap true :silent true}"
  (vim.api.nvim_set_keymap mode from to {:noremap true :silent true}))

(fn noremap-silent-expr [mode from to]
  "Sets a mapping with {:noremap true :silent true :expr true}"
  (vim.api.nvim_set_keymap mode from to {:noremap true :silent true :expr true}))

(fn hide-terminal []
  (vim.cmd.FloatermHide))
(util.export :hide_terminal hide-terminal)

(fn setup-terminal []
  (tset vim.g "floaterm_width" (- (. vim.o "columns") 10))
  (tset vim.g "floaterm_height" (- (. vim.o "lines") 5)))

(fn update-terminal []
  (vim.cmd.FloatermUpdate (.. "--width=" vim.g.floaterm_width " --height=" vim.g.floaterm_height)))

(fn toggle-terminal []
  (setup-terminal)
  (vim.cmd.FloatermToggle)
  (update-terminal))
(util.export :toggle_terminal toggle-terminal)

(fn new-terminal []
  (vim.cmd.FloatermNew))
(util.export :new_terminal new-terminal)

(fn next-terminal []
  (vim.cmd.FloatermNext)
  (update-terminal))
(util.export :next_terminal next-terminal)

(fn previous-terminal []
  (vim.cmd.FloatermPrev)
  (update-terminal))
(util.export :previous_terminal previous-terminal)

;; LEADER ;;
;;;;;;;;;;;;

(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(whichkey.register
  {:v {:name "Vim"
       :l [":Lazy<CR>" "lazy"]
       :m [":Mason<CR>" "mason"]
       :e (let [config-path (vim.fn.stdpath "config")]
               {:name "Edit"
                :i [(.. ":e " config-path "/init.fnl<CR>") "init.fnl"]
                :b [(.. ":e " config-path "/fnl/bindings.fnl<CR>") "bindings.fnl"]
                :p [(.. ":e " config-path "/fnl/plugins.fnl<CR>") "plugins.fnl"]
                :s [(.. ":e " config-path "/fnl/settings.fnl<CR>") "settings.fnl"]
                :l [(.. ":e " config-path "/fnl/lsp.fnl<CR>") "lsp.fnl"]
                :t [(.. ":e " config-path "/fnl/treesitter.fnl<CR>") "treesitter.fnl"]
                :u [(.. ":e " config-path "/fnl/util.fnl<CR>") "util.fnl"]})}
   :q {:name "Quit"
       :q [":FloatermKill!<CR>:wqall!<CR>" "quit and save everything"]
       :r [":FloatermKill!<CR>:Obsession ~/session.vim<CR>:!start c:/dev/Tools/neovide.exe -- -S ~/session.vim<CR><CR>:wqall!<CR>" "quit and reload"]}
   :w {:name "Windows"
       :h ["<C-w>h" "jump left"]
       :j ["<C-w>j" "jump down"]
       :k ["<C-w>k" "jump up"]
       :l ["<C-w>l" "jump right"]
       :y [":vsplit<CR><ESC>" "split left"]
       :u [":split<CR><C-w>j<ESC>" "split down"]
       :i [":split<CR><ESC>" "split up"]
       :o [":vsplit<CR><C-w>l<ESC>" "split right"]}
   :b {:name "Buffers"
       :b [":lua require'telescope.builtin'.buffers{}<CR>" "list"]
       :h ["<cmd>BufferPrevious<CR>" "previous"]
       :l ["<cmd>BufferNext<CR>" "next"]
       :k ["<cmd>BufferFirst<CR>" "first"]
       :j ["<cmd>BufferLast<CR>" "last"]
       :d ["<cmd>BufferClose<CR>" "delete"]
       :D ["<cmd>BufferClose!<CR>" "delete without saving"]}
   :f {:name "Files"
       :f [":Telescope frecency<CR>" "recent"]
       :p [":lua require'telescope'.extensions.project.project{}<CR>" "project"]
       :e [":NfnlFile %<CR>" "eval fnl"]
       :E [":luafile %<CR>" "eval lua"]
       :s [":w<CR>" "save"]
       :c [":cd %:h<CR>" "cd to file"]}
   :t {:name "Terminal"
       :t ["<ESC>:call v:lua.g.toggle_terminal()<CR>" "Open Terminal"]
       :n ["<ESC>:call v:lua.g.new_terminal()<CR>" "New Terminal"]
       :l ["<ESC>:call v:lua.g.next_terminal()<CR>" "Next Terminal"]
       :h ["<ESC>:call v:lua.g.previous_terminal()<CR>" "Previous Terminal"]}
   :x {:name "teXt"
       :i ["<cmd>Sleuth<CR>" "Autodetect Indent Settings"]
       ";" ["<cmd>Commentary<CR>" "Comment current line"]}
   "l" {:name "LSP"
        :h ["<cmd>Lspsaga hover_doc<CR>" "Hover"]
        :H ["<cmd>Lspsaga <cmd>Lspsaga show_cursor_diagnostics<CR>" "Hover Diagnostics"]
        :d ["<cmd>Lspsaga goto_definition<CR>" "Goto Definition"]
        :r ["<cmd>Lspsaga rename<CR>" "Rename"]
        :. ["<cmd>Lspsaga code_action<CR>" "Code Action"]
        :n ["<cmd>Lspsaga diagnostic_jump_next<CR>" "Next Diagnostic"]
        :p ["<cmd>Lspsaga diagnostic_jump_prev<CR>" "Previous Diagnostic"]
        :o [":lua require'telescope.builtin'.lsp_document_symbols{}<CR>" "Outline"]
        :D ["<cmd>Trouble workspace_diagnostics<CR>" "Diagnostic List"]
        :R [":LspRestart<CR>" "Restart LSP"]}
   "d" {:name "DAP"
        :d ["<cmd>lua require'dap'.continue()<CR>" "Continue/Start"]
        :h ["<cmd>lua require'dap'.step_back()<CR>" "Step Back"]
        :j ["<cmd>lua require'dap'.step_into()<CR>" "Step Into"]
        :k ["<cmd>lua require'dap'.step_out()<CR>" "Step Out"]
        :l ["<cmd>lua require'dap'.step_over()<CR>" "Step Over"]
        :u ["<cmd>lua require'dap'.down()<CR>" "Down"]
        :i ["<cmd>lua require'dap'.up()<CR>" "Up"]
        :b ["<cmd>lua require'dap'.toggle_breakpoint()<CR>" "Toggle Breakpoint"]
        :h ["<cmd>lua require'dap.ui.widgets'.hover()<CR>" "Hover"]
        :t ["<cmd>lua require'dapui'.toggle()<CR>" "Toggle DAP UI"]
        :q ["<cmd>lua require'dap'.close()<CR>" "Close"]}
   ":" [":lua require'telescope.builtin'.commands{}<CR>" "Commands"]}
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

(map-silent :n "<ESC>" 
  (.. ":noh<CR>"
      ":call v:lua.g.hide_terminal()<CR>"))
(leap.add_default_mappings)


