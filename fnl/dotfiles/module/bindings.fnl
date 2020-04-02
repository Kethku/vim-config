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

(defn- declare-command [body]
  (nvim.command (.. "command! " body)))

(defn- declare-command-with-args [body]
  (nvim.command (.. "command! -nargs=+ " body)))

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

(defn okeydokey [args]
  (nvim.command (.. "!pwsh -Command ok " args)))

(defn okeydokey-loc [args]
  (nvim.command 
    (.. "!pwsh -Command ok " args 
        (nvim.ex.resolve "%:p") " " 
        (nvim.ex.line ".") " " 
        (nvim.ex.col "."))))

(declare-command-with-args "Ok :lua okeydokey(<q-args>)")
(declare-command-with-args "OkLoc :lua okeydokey-loc(<q-args>)")

;; LEADER ;;
;;;;;;;;;;;;

(set nvim.g.mapleader "\\<Space>")
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
(define-binding :n [:v :r] "reload config" ":source $MYVIMRC<CR>")
(define-binding :n [:v :u] "update plugins" ":source $MYVIMRC<CR>:call dein#update()<CR>")
(define-binding :n [:v :i] "install plugins" ":source $MYVIMRC<CR>:call dein#install()<CR>")
(define-category [:v :e] "+edit")
(define-binding :n [:v :e :i] "init.fnl" ":e $MYVIMRC/../fnl/dotfiles/init.fnl<CR>")
(define-binding :n [:v :e :b] "bindings.fnl" ":e $MYVIMRC/../fnl/dotfiles/module/bindings.fnl<CR>")
(define-binding :n [:v :e :p] "init.vim (plugins)" ":e $MYVIMRC<CR>")
(define-binding :n [:v :e :s] "settings" ":e $MYVIMRC/../fnl/dotfiles/module/settings.fnl<CR>")

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
(define-binding :n [:w :o] "split right" "vsplit<CR><C-w>l<ESC>")
(define-binding :n [:w :=] "auto resize" "<Plug>(golden_ratio_resize)")

(define-category [:b] "+buffers")
(define-binding :n [:b :b] "buffers" ":Buffers<CR>")
(define-binding :n [:b :h] "previous" ":bprevious<CR>")
(define-binding :n [:b :l] "next" ":bnext<CR>")
(define-binding :n [:b :k] "first" ":bfirst<CR>")
(define-binding :n [:b :j] "last" ":blast<CR>")
(define-binding :n [:b :d] "delete" ":BD<CR>")

(define-category [:f] "+file")
(define-binding :n [:f :r] "recent" ":History<CR>")
(define-binding :n [:f :s] "save" ":w<CR>")
(define-binding :n [:f :f] "format" ":CocCommand prettier.formatFile<CR>")

(define-category [:k] "+kill")
(define-binding :n [:k :w] "window" ":wq<CR>")

(define-category [:t] "+terminal")
(define-binding :n [:t :t] "Open Terminal" "<ESC>:call ")

let g:which_key_map.t = { 'name' : '+terminal' }
nmap <silent> <leader>tt <Esc>:call ToggleTerminal()<CR>
let g:which_key_map.t.t = 'Open Floating Terminal'
nmap <silent> <leader>tn <Esc>:call NewTerminal()<CR>
let g:which_key_map.t.n = 'New Floating Terminal'
nmap <silent> <leader>tl <Esc>:call NextTerminal()<CR>
let g:which_key_map.t.l = 'Next Floating Terminal'
nmap <silent> <leader>th <Esc>:call PreviousTerminal()<CR>
let g:which_key_map.t.h = 'Previous Floating Terminal'

let g:which_key_map[';'] = { 'name' : '+commentary' }
nnoremap <silent> <leader>;; :.Commentary<CR>
let g:which_key_map[';'][';'] = 'current line'

let g:which_key_map[' '] = { 'name' : '+easymotion' }
nmap <silent> <leader><leader>f <Plug>(easymotion-f)
let g:which_key_map[' '].f = 'f{char} jump to character'
nmap <silent> <leader><leader>F <Plug>(easymotion-F)
let g:which_key_map[' '].F = 'F{char} jump backwards to character'
nmap <silent> <leader><leader>t <Plug>(easymotion-t)
let g:which_key_map[' '].t = 't{char} jump to before character'
nmap <silent> <leader><leader>T <Plug>(easymotion-T)
let g:which_key_map[' '].T = 'T{char} jump backwards to after character'
nmap <silent> <leader><leader>w <Plug>(easymotion-w)
let g:which_key_map[' '].w = 'w jump to word'
nmap <silent> <leader><leader>W <Plug>(easymotion-W)
let g:which_key_map[' '].W = 'W jump to WORD'
nmap <silent> <leader><leader>b <Plug>(easymotion-b)
let g:which_key_map[' '].b = 'b jump backwards to word'
nmap <silent> <leader><leader>B <Plug>(easymotion-B)
let g:which_key_map[' '].B = 'B jump backwards to WORD'
nmap <silent> <leader><leader>e <Plug>(easymotion-e)
let g:which_key_map[' '].e = 'e jump to end of word'
nmap <silent> <leader><leader>E <Plug>(easymotion-E)
let g:which_key_map[' '].E = 'E jump to end of WORD'
let g:which_key_map[' '].g = { 'name' : '+back' }
nmap <silent> <leader><leader>ge <Plug>(easymotion-ge)
let g:which_key_map[' '].g.e = 'ge jump backwards to end of word'
nmap <silent> <leader><leader>gE <Plug>(easymotion-gE)
let g:which_key_map[' '].g.E = 'gE jump backwards to end of WORD'
nmap <silent> <leader><leader>j <plug>(easymotion-j)
let g:which_key_map[' '].j = 'j jump down to line'
nmap <silent> <leader><leader>k <plug>(easymotion-k)
let g:which_key_map[' '].k = 'k jump up to line'
nmap <silent> <leader><leader>n <plug>(easymotion-n)
let g:which_key_map[' '].n = 'n jump to search result'
nmap <silent> <leader><leader>N <plug>(easymotion-N)
let g:which_key_map[' '].N = 'N jump to previous search result'
