local _0_0 = nil
do
  local name_0_ = "dotfiles.module.bindings"
  local loaded_0_ = package.loaded[name_0_]
  local module_0_ = nil
  if ("table" == type(loaded_0_)) then
    module_0_ = loaded_0_
  else
    module_0_ = {}
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = (module_0_["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = (module_0_["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local function _2_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _2_()
    return {require("dotfiles.module.bindings"), require("aniseed.core"), require("aniseed.nvim"), require("dotfiles.util")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {bindings = "dotfiles.module.bindings", core = "aniseed.core", nvim = "aniseed.nvim", util = "dotfiles.util"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _1_ = _2_(...)
local bindings = _1_[1]
local core = _1_[2]
local nvim = _1_[3]
local util = _1_[4]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "dotfiles.module.bindings"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
nvim.command("colorscheme gruvbox")
nvim.command("filetype plugin indent on")
nvim.command("autocmd BufEnter * silent! lcd &:p:h")
nvim.g.airline_powerline_fonts = 1
nvim.g.airline_section_z = "%3l/%L:%3v"
nvim.g.airline_left_sep = "\238\130\180"
nvim.g.airline_right_sep = "\238\130\182"
nvim.g["airline#extensions#coc#enabled"] = 1
nvim.g.airline_section_warning = ""
nvim.g.airline_section_error = ""
nvim.g["airline#extensions#tabline#enabled"] = 1
nvim.g["airline#extensions#tabline#show_tab_type"] = 0
nvim.g["airline#extensions#tabline#switch_buffers_and_tabs"] = 1
nvim.g["airline#extensions#tabline#buffers_label"] = "B"
nvim.g["airline#extensions#tabline#tabs_label"] = "T"
nvim.g["airline#extensions#tabline#formatter"] = "unique_tail"
nvim.g.markdown_fenced_languages = {"javascript", "typescript", "js=javascript"}
nvim.g.vim_markdown_folding_disabled = 1
nvim.g.gruvbox_invert_selection = 1
nvim.g.floaterm_winblend = 20
nvim.g.floaterm_position = "center"
nvim.g.neovide_cursor_animation_length = 0.080000000000000002
nvim.g.neovide_refresh_rate = 150
local floating_fzf = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function floating_fzf0()
      local float2nr = nvim.fn.float2nr
      local columns = nvim.o.columns
      local height = nvim.o.lines
      local width = float2nr((columns - (columns * (2 / 10))))
      local window_height = float2nr((height / 3))
      local col = float2nr(((columns - width) / 2))
      local col_offset = (columns / 10)
      local options = {col = (col + col_offset), height = window_height, relative = "editor", row = (height - window_height), style = "minimal", width = (width * 2)}
      local buf = nvim.create_buf(false, true)
      local win = nvim.open_win(buf, true, options)
      nvim.wo["winhl"] = "NormalFloat:TabLine"
      return nil
    end
    v_0_0 = floating_fzf0
    _0_0["floating-fzf"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["floating-fzf"] = v_0_
  floating_fzf = v_0_
end
util.export("floating_fzf", floating_fzf)
nvim.g.fzf_layout = {window = "call v:lua.g.floating_fzf()"}
nvim.o.guifont = "Delugia Nerd Font:h12"
nvim.o.winblend = 20
nvim.o.pumblend = 20
nvim.o.ve = "block"
nvim.o.mouse = "a"
nvim.o.clipboard = "unnamed"
nvim.o.timeoutlen = 100
nvim.o.textwidth = 120
nvim.o.conceallevel = 3
local set_option = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function set_option0(option)
      return nvim.command(("set " .. option))
    end
    v_0_0 = set_option0
    _0_0["set-option"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["set-option"] = v_0_
  set_option = v_0_
end
set_option("nonumber")
set_option("termguicolors")
set_option("expandtab")
set_option("hlsearch")
set_option("ignorecase")
set_option("smartcase")
set_option("noshowmode")
set_option("hidden")
return set_option("nowrap")