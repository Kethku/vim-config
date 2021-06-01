(module module.settings
  {require {core aniseed.core
            util util}})

(vim.cmd "colorscheme gruvbox")
(vim.cmd "filetype plugin indent on")
(vim.cmd "autocmd BufEnter * silent! lcd &:p:h")

; Airline
(set vim.g.airline_powerline_fonts 1)
(set vim.g.airline_section_z "%3l/%L:%3v")
(set vim.g.airline_left_sep "")
(set vim.g.airline_right_sep "")
(set vim.g.airline#extensions#coc#enabled 1)
(set vim.g.airline_section_warning "")
(set vim.g.airline_section_error "")
; Tabline
(set vim.g.airline#extensions#tabline#enabled 1)
(set vim.g.airline#extensions#tabline#show_tab_type 0)
(set vim.g.airline#extensions#tabline#switch_buffers_and_tabs 1)
(set vim.g.airline#extensions#tabline#buffers_label "B")
(set vim.g.airline#extensions#tabline#tabs_label "T")
(set vim.g.airline#extensions#tabline#formatter "unique_tail")

(set vim.g.markdown_fenced_languages ["javascript" "typescript" "js=javascript"])
(set vim.g.vim_markdown_folding_disabled 1)

(set vim.g.gruvbox_invert_selection 1)

(set vim.g.floaterm_winblend 20)
(set vim.g.floaterm_position "center")

(set vim.g.neovide_refresh_rate 150)

(set vim.o.guifont "Delugia Nerd Font,Segoe UI Emoji,Microsoft YaHei:h12")
(set vim.o.winblend 20)
(set vim.o.pumblend 20)
(set vim.o.ve "block")
(set vim.o.mouse "a")
(set vim.o.clipboard "unnamed")
(set vim.o.timeoutlen 100)
(set vim.o.textwidth 120)
(set vim.o.conceallevel 3)

(defn set-option [option]
  (vim.cmd (.. "set " option)))

(set-option :nonumber)
(set-option :termguicolors)
(set-option :expandtab)
(set-option :hlsearch)
(set-option :ignorecase)
(set-option :smartcase)
(set-option :noshowmode)
(set-option :hidden)
(set-option :nowrap)
