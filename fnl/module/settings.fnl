(module module.settings
  {require {core    aniseed.core
            util    util
            lualine lualine
            satellite satellite
            aerial aerial
            gitsigns gitsigns}})

(vim.cmd "filetype plugin indent on")
(vim.cmd "autocmd BufEnter * silent! lcd &:p:h")
(vim.cmd "autocmd FileType markdown setlocal spell")
(vim.cmd "autocmd FileType markdown set textwidth=60")
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

;; Neovide
(set vim.g.neovide_refresh_rate 150)

;; Aerial
(aerial.setup
  {:layout {:default_direction "float"}
   :float {:relative "editor"}})

;; Gitsigns
(gitsigns.setup)

;; AI
(set vim.g.ai_completions_model "gpt-3.5-turbo")

;; Completions
(set vim.g.coq_settings {:auto_start "shut-up"})

;; Options
(set vim.o.guifont "Cascadia Code PL,Delugia Nerd Font:h14")
(set vim.o.winblend 20)
(set vim.o.pumblend 20)
(set vim.o.ve "block")
(set vim.o.mouse "a")
(set vim.o.clipboard "unnamed")
(set vim.o.timeoutlen 500)
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
