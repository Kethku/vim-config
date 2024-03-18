-- [nfnl] Compiled from fnl/resize.fnl by https://github.com/Olical/nfnl, do not edit.
local core = require("nfnl.core")
local util = require("util")
local function golden_ratio_width()
  return (vim.o.columns() / 1.61803398875)
end
local function golden_ratio_height()
  return (vim.o.lines() / 1.61803398875)
end
local function window_list()
  local function _1_(win)
    _G.assert((nil ~= win), "Missing argument win on C:/Users/KaySimmons/AppData/Local/nvim/fnl/resize.fnl:12")
    return (vim.api.nvim_win_get_config(win).relative == "")
  end
  return core.filter(_1_, vim.api.nvim_tabpage_list_wins(0))
end
local function find_parallel_windows(current_win)
  local windows = window_list()
  local function _2_(win)
    _G.assert((nil ~= win), "Missing argument win on C:/Users/KaySimmons/AppData/Local/nvim/fnl/resize.fnl:19")
    return ((win ~= current_win) and (vim.api.nvim_win_get_height(win) == vim.api.nvim_win_get_height(current_win)))
  end
  local function _3_(win)
    _G.assert((nil ~= win), "Missing argument win on C:/Users/KaySimmons/AppData/Local/nvim/fnl/resize.fnl:24")
    return ((win ~= current_win) and (vim.api.nvim_win_get_width(win) == vim.api.nvim_win_get_width(current_win)))
  end
  return {width = core.filter(_2_, windows), height = core.filter(_3_, windows)}
end
local function resize_ignored_window(win, window_list0, ignored_width, ignored_height)
  if (not core["empty?"](window_list0.width) and util["contains?"](window_list0.widht, win)) then
    local width_size
    local function _4_()
      return window_list0.width
    end
    width_size = (ignored_width / _4_)
    vim.api.nvim_win_set_width(win, width_size)
  else
  end
  if (not core["empty?"](window_list0.height) and util["contains?"](window_list0.height, win)) then
    local height_size
    local function _6_()
      return window_list0.height
    end
    height_size = (ignored_height / _6_)
    return vim.api.nvim_win_set_height(win, height_size)
  else
    return nil
  end
end
return resize_ignored_window
