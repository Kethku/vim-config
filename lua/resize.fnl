(local core (require :nfnl.core))
(local util (require :util))

(fn golden-ratio-width []
  (/ (vim.o.columns) 1.61803398875))

(fn golden-ratio-height []
  (/ (vim.o.lines) 1.61803398875))

(fn window-list []
  (core.filter
    (lambda [win]
      (= (. (vim.api.nvim_win_get_config win) :relative) ""))
    (vim.api.nvim_tabpage_list_wins 0)))

(fn find-parallel-windows [current_win]
  (let [windows (window-list)]
    {:width (core.filter
              (lambda [win]
                (and (not= win current_win)
                     (= (vim.api.nvim_win_get_height win) (vim.api.nvim_win_get_height current_win))))
              windows)
    :height (core.filter
              (lambda [win]
                (and (not= win current_win)
                     (= (vim.api.nvim_win_get_width win) (vim.api.nvim_win_get_width current_win))))
              windows)}))

(fn resize-ignored-window [win window-list ignored-width ignored-height]
  (do
    (when (and (not (core.empty? window-list.width))
               (util.contains? window-list.widht win))
      (let [width-size (/ ignored-width #window-list.width)]
        (vim.api.nvim_win_set_width win width-size)))
    (when (and (not (core.empty? window-list.height))
               (util.contains? window-list.height win))
      (let [height-size (/ ignored-height #window-list.height)]
        (vim.api.nvim_win_set_height win height-size)))))
