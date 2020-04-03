local _0_0 = nil
do
  local name_23_0_ = "dotfiles.module.bindings"
  local loaded_23_0_ = package.loaded[name_23_0_]
  local module_23_0_ = nil
  if ("table" == type(loaded_23_0_)) then
    module_23_0_ = loaded_23_0_
  else
    module_23_0_ = {}
  end
  module_23_0_["aniseed/module"] = name_23_0_
  module_23_0_["aniseed/locals"] = (module_23_0_["aniseed/locals"] or {})
  module_23_0_["aniseed/local-fns"] = (module_23_0_["aniseed/local-fns"] or {})
  package.loaded[name_23_0_] = module_23_0_
  _0_0 = module_23_0_
end
local function _1_(...)
  _0_0["aniseed/local-fns"] = {require = {core = "aniseed.core", nvim = "aniseed.nvim"}}
  return {require("aniseed.core"), require("aniseed.nvim")}
end
local _2_ = _1_(...)
local core = _2_[1]
local nvim = _2_[2]
do local _ = ({nil, _0_0, nil})[2] end
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
nvim.g.neovide_refresh_rate = 144
local floating_fzf = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function floating_fzf0()
      local float2nr = nvim.fn.float2nr
      local columns = nvim.o.columns
      local height = nvim.o.lines
      local width = float2nr((columns - (columns * (2 / 10))))
      local window_height = (height / 3)
      local col = float2nr(((columns - width) / 2))
      local col_offset = (columns / 10)
      local options = {col = (col + col_offset), height = window_height, relative = "editor", row = (height - window_height), style = "minimal", width = (width * 2)}
      local buf = nvim.create_buf(false, true)
      local win = nvim.open_win(buf, true, options)
      nvim.o[win]["winhl"] = "NormalFloat:TabLine"
      return nil
    end
    v_23_0_0 = floating_fzf0
    _0_0["floating-fzf"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["floating-fzf"] = v_23_0_
  floating_fzf = v_23_0_
end
nvim.g.fzf_layout = {window = "lua floating-fzf()"}
nvim.o.guifont = "Delugia\\ Nerd\\ Font:h12"
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
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function set_option0(option)
      return nvim.command(("set " .. option))
    end
    v_23_0_0 = set_option0
    _0_0["set-option"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["set-option"] = v_23_0_
  set_option = v_23_0_
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