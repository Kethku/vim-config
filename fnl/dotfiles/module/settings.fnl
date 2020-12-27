(module dotfiles.module.bindings
  {require {nvim     aniseed.nvim
            core     aniseed.core
            util     dotfiles.util
            bindings dotfiles.module.bindings}})

(nvim.command "colorscheme gruvbox")
(nvim.command "filetype plugin indent on")
(nvim.command "autocmd BufEnter * silent! lcd &:p:h")

(set nvim.g.airline_powerline_fonts 1)
(set nvim.g.airline_section_z "%3l/%L:%3v")
(set nvim.g.airline_left_sep "")
(set nvim.g.airline_right_sep "")
(set nvim.g.airline#extensions#coc#enabled 1)
(set nvim.g.airline_section_warning "")
(set nvim.g.airline_section_error "")
; Tabline
(set nvim.g.airline#extensions#tabline#enabled 1)
(set nvim.g.airline#extensions#tabline#show_tab_type 0)
(set nvim.g.airline#extensions#tabline#switch_buffers_and_tabs 1)
(set nvim.g.airline#extensions#tabline#buffers_label "B")
(set nvim.g.airline#extensions#tabline#tabs_label "T")
(set nvim.g.airline#extensions#tabline#formatter "unique_tail")

(set nvim.g.markdown_fenced_languages ["javascript" "typescript" "js=javascript"])
(set nvim.g.vim_markdown_folding_disabled 1)

(set nvim.g.gruvbox_invert_selection 1)

(set nvim.g.floaterm_winblend 20)
(set nvim.g.floaterm_position "center")

(set nvim.g.neovide_cursor_animation_length 0.08)
(set nvim.g.neovide_refresh_rate 150)

(defn floating-fzf []
  (let [float2nr nvim.fn.float2nr
        columns nvim.o.columns
        height nvim.o.lines
        width (float2nr (- columns (* columns (/ 2 10))))
        window_height (float2nr (/ height 3))
        col (float2nr (/ (- columns width) 2))
        col_offset (/ columns 10)
        options {:relative "editor"
              :row (- height window_height)
              :col (+ col col_offset)
              :width (* width 2)
              :height window_height
              :style "minimal"}
        buf (nvim.create_buf false true)
        win (nvim.open_win buf true options)]
    (tset nvim.wo :winhl "NormalFloat:TabLine")))
(util.export :floating_fzf floating-fzf)

(set nvim.g.fzf_layout {:window "call v:lua.g.floating_fzf()"})

(set nvim.o.guifont "Delugia Nerd Font:h12")
(set nvim.o.winblend 20)
(set nvim.o.pumblend 20)
(set nvim.o.ve "block")
(set nvim.o.mouse "a")
(set nvim.o.clipboard "unnamed")
(set nvim.o.timeoutlen 100)
(set nvim.o.textwidth 120)
(set nvim.o.conceallevel 3)

(defn set-option [option]
  (nvim.command (.. "set " option)))

(set-option :nonumber)
(set-option :termguicolors)
(set-option :expandtab)
(set-option :hlsearch)
(set-option :ignorecase)
(set-option :smartcase)
(set-option :noshowmode)
(set-option :hidden)
(set-option :nowrap)
