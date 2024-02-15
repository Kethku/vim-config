(local lualine (require "lualine"))
(local satellite (require "satellite"))
(local telescope (require "telescope"))
(local autocmd vim.api.nvim_create_autocmd)

(local util (require "util"))

(vim.cmd "filetype plugin indent on")
(vim.cmd "autocmd BufEnter * silent! lcd &:p:h")
(vim.cmd "autocmd FileType markdown setlocal spell")
(vim.cmd "autocmd FileType markdown set textwidth=60")

; ;; This resets the window positions of non active windows for some reason.
; ;; TODO: Use nvim_win_get_position, and extmarks to save the positions of
; ;; windows containing this buffer and restore them after the format request
; ;; completes.
; (fn format_buffer []
;   ;; TODO: loop over windows containing the given bufnum and store the current positions
;   (vim.lsp.buf.format)
;   ;; TODO: restore the stored positions. Note: this might have to wait for the format
;   ;; request to complete.
;   )
; (util.export :format_buffer format_buffer)
(vim.cmd "autocmd BufWritePre * silent! lua vim.lsp.buf.format()")

;; LuaLine
(lualine.setup 
  {:options {:icons_enabled true
             :theme "auto"
             :component_separators {:left "" :right ""}
             :section_separators {:left "" :right ""}
             :always_divide_middle true}
   :sections {:lualine_a ["mode"]
              :lualine_b ["branch" "diff" "diagnostics"]
              :lualine_c ["filename"]
              :lualine_x ["encoding" "fileformat" "filetype"]
              :lualine_y ["progress"]
              :lualine_z ["location"]}
   :inactive_sections {:lualine_a []
                       :lualine_b []
                       :lualine_c ["filename"]
                       :lualine_x ["location"]
                       :lualine_y []
                       :lualine_z []}})

;; Markdown
(set vim.g.markdown_fenced_languages ["javascript" "typescript" "js=javascript"])
(set vim.g.vim_markdown_folding_disabled 1)

;; Colors
(set vim.g.gruvbox_invert_selection 1)
(vim.cmd "colorscheme gruvbox")

;; Terminal
(vim.cmd "autocmd FileType floaterm setlocal winblend=10")
(set vim.g.floaterm_position "center")
(set vim.g.floaterm_shell "pwsh")

;; Telescope

(telescope.load_extension "project")

;; Neovide
(set vim.g.neovide_refresh_rate 60)
(set vim.g.neovide_scroll_animation_length 0.2)
(set vim.g.neovide_remember_window_size true)

;; Scrollbar
(satellite.setup {:width 0})

;; Completions
(set vim.g.coq_settings {:auto_start "shut-up"})

;; Options
(set vim.o.winblend 20)
(set vim.o.pumblend 20)
(set vim.o.ve "block")
(set vim.o.mouse "a")
(set vim.o.clipboard "unnamedplus")
(set vim.o.timeoutlen 500)
(set vim.o.textwidth 120)
(set vim.o.conceallevel 3)
(set vim.o.signcolumn "no")
(set vim.o.laststatus 3)
(set vim.o.number false)
(set vim.o.termguicolors true)
(set vim.o.expandtab true)
(set vim.o.hlsearch true)
(set vim.o.ignorecase true)
(set vim.o.smartcase true)
(set vim.o.showmode false)
(set vim.o.hidden true)
(set vim.o.wrap false)
(set vim.o.splitkeep "screen")
(set vim.o.mousemodel "extend")
