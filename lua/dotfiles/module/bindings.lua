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
local function _1_(...)
  _0_0["aniseed/local-fns"] = {require = {core = "aniseed.core", nvim = "aniseed.nvim", util = "dotfiles.util"}}
  return {require("aniseed.core"), require("aniseed.nvim"), require("dotfiles.util")}
end
local _2_ = _1_(...)
local core = _2_[1]
local nvim = _2_[2]
local util = _2_[3]
do local _ = ({nil, _0_0, {{}, nil}})[2] end
local map = nil
do
  local v_0_ = nil
  local function map0(mode, from, to)
    return nvim.set_keymap(mode, from, to, {})
  end
  v_0_ = map0
  _0_0["aniseed/locals"]["map"] = v_0_
  map = v_0_
end
local map_silent = nil
do
  local v_0_ = nil
  local function map_silent0(mode, from, to)
    return nvim.set_keymap(mode, from, to, {silent = true})
  end
  v_0_ = map_silent0
  _0_0["aniseed/locals"]["map-silent"] = v_0_
  map_silent = v_0_
end
local noremap = nil
do
  local v_0_ = nil
  local function noremap0(mode, from, to)
    return nvim.set_keymap(mode, from, to, {noremap = true})
  end
  v_0_ = noremap0
  _0_0["aniseed/locals"]["noremap"] = v_0_
  noremap = v_0_
end
local noremap_silent = nil
do
  local v_0_ = nil
  local function noremap_silent0(mode, from, to)
    return nvim.set_keymap(mode, from, to, {noremap = true, silent = true})
  end
  v_0_ = noremap_silent0
  _0_0["aniseed/locals"]["noremap-silent"] = v_0_
  noremap_silent = v_0_
end
local declare_command = nil
do
  local v_0_ = nil
  local function declare_command0(body)
    return nvim.command(("command! " .. body))
  end
  v_0_ = declare_command0
  _0_0["aniseed/locals"]["declare-command"] = v_0_
  declare_command = v_0_
end
local declare_command_with_args = nil
do
  local v_0_ = nil
  local function declare_command_with_args0(body)
    return nvim.command(("command! -nargs=+ " .. body))
  end
  v_0_ = declare_command_with_args0
  _0_0["aniseed/locals"]["declare-command-with-args"] = v_0_
  declare_command_with_args = v_0_
end
local is_terminal_buffer = nil
do
  local v_0_ = nil
  local function is_terminal_buffer0(bufnumber)
    return ((nvim.bo[bufnumber].buftype == "terminal") and (nvim.b[bufnumber].floaterm_window == 1))
  end
  v_0_ = is_terminal_buffer0
  _0_0["aniseed/locals"]["is-terminal-buffer"] = v_0_
  is_terminal_buffer = v_0_
end
local is_terminal_window = nil
do
  local v_0_ = nil
  local function is_terminal_window0(winnr)
    return is_terminal_buffer(nvim.fn.winbufnr(winnr))
  end
  v_0_ = is_terminal_window0
  _0_0["aniseed/locals"]["is-terminal-window"] = v_0_
  is_terminal_window = v_0_
end
local find_terminal_window = nil
do
  local v_0_ = nil
  local function find_terminal_window0()
    return core.first(core.filter(is_terminal_window, nvim.fn.range(1, nvim.fn.winnr("$"))))
  end
  v_0_ = find_terminal_window0
  _0_0["aniseed/locals"]["find-terminal-window"] = v_0_
  find_terminal_window = v_0_
end
util.export("find_terminal_window", find_terminal_window)
local hide_terminal = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function hide_terminal0()
      local winnr = find_terminal_window()
      if not core["nil?"](winnr) then
        return nvim.command((winnr .. " wincmd q"))
      end
    end
    v_0_0 = hide_terminal0
    _0_0["hide-terminal"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["hide-terminal"] = v_0_
  hide_terminal = v_0_
end
util.export("hide_terminal", hide_terminal)
local setup_terminal = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function setup_terminal0()
      nvim.g["floaterm_width"] = (nvim.o.columns - 10)
      nvim.g["floaterm_height"] = (nvim.o.lines - 5)
      return nil
    end
    v_0_0 = setup_terminal0
    _0_0["setup-terminal"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["setup-terminal"] = v_0_
  setup_terminal = v_0_
end
local toggle_terminal = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function toggle_terminal0()
      setup_terminal()
      nvim.o.shell = "pwsh"
      nvim.ex.FloatermToggle()
      nvim.o.shell = "cmd"
      return nil
    end
    v_0_0 = toggle_terminal0
    _0_0["toggle-terminal"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["toggle-terminal"] = v_0_
  toggle_terminal = v_0_
end
util.export("toggle_terminal", toggle_terminal)
local new_terminal = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function new_terminal0()
      setup_terminal()
      nvim.o.shell = "pwsh"
      nvim.ex.FloatermNew()
      nvim.o.shell = "cmd"
      return nil
    end
    v_0_0 = new_terminal0
    _0_0["new-terminal"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["new-terminal"] = v_0_
  new_terminal = v_0_
end
util.export("new_terminal", new_terminal)
local next_terminal = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function next_terminal0()
      setup_terminal()
      return nvim.ex.FloatermNext()
    end
    v_0_0 = next_terminal0
    _0_0["next-terminal"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["next-terminal"] = v_0_
  next_terminal = v_0_
end
util.export("next_terminal", next_terminal)
local previous_terminal = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function previous_terminal0()
      setup_terminal()
      return nvim.ex.FloatermPrev()
    end
    v_0_0 = previous_terminal0
    _0_0["previous-terminal"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["previous-terminal"] = v_0_
  previous_terminal = v_0_
end
util.export("previous_terminal", previous_terminal)
local okeydokey = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function okeydokey0(args)
      return nvim.command(("!pwsh -Command ok " .. args))
    end
    v_0_0 = okeydokey0
    _0_0["okeydokey"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["okeydokey"] = v_0_
  okeydokey = v_0_
end
util.export("okeydokey", okeydokey)
local okeydokey_loc = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function okeydokey_loc0(args)
      return nvim.command(("!pwsh -Command ok " .. args .. nvim.ex.resolve("%:p") .. " " .. nvim.ex.line(".") .. " " .. nvim.ex.col(".")))
    end
    v_0_0 = okeydokey_loc0
    _0_0["okeydokey-loc"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["okeydokey-loc"] = v_0_
  okeydokey_loc = v_0_
end
util.export("okeydokey_loc", okeydokey_loc)
declare_command_with_args("Ok call v:lua.g.okeydokey(<q-args>)")
declare_command_with_args("OkLoc call v:lua.g.okeydokey_loc(<q-args>)")
nvim.g.mapleader = " "
nvim.g.maplocalleader = ","
noremap_silent("n", "<leader>", ":<c-u>WhichKey '<Space>'<CR>")
noremap_silent("v", "<leader>", ":<c-u>WhichKeyVisual '<Space>'<CR>")
which_key_map = {}
local define_category = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function define_category0(keys, documentation)
      core["get-in"](which_key_map, core.butlast(keys), nil)[core.last(keys)] = {name = documentation}
      return nil
    end
    v_0_0 = define_category0
    _0_0["define-category"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["define-category"] = v_0_
  define_category = v_0_
end
local concat = nil
do
  local v_0_ = nil
  local function concat0(a, b)
    return (a .. b)
  end
  v_0_ = concat0
  _0_0["aniseed/locals"]["concat"] = v_0_
  concat = v_0_
end
local define_binding = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function define_binding0(mode, keys, documentation, body)
      core["get-in"](which_key_map, core.butlast(keys))[core.last(keys)] = documentation
      return noremap_silent(mode, core.reduce(concat, "<leader>", keys), body)
    end
    v_0_0 = define_binding0
    _0_0["define-binding"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["define-binding"] = v_0_
  define_binding = v_0_
end
define_category({"v"}, "+vim")
define_binding("n", {"v", "r"}, "reload config", ":source $MYVIMRC<CR>")
define_binding("n", {"v", "u"}, "update plugins", ":source $MYVIMRC<CR>:call dein#update()<CR>")
define_binding("n", {"v", "i"}, "install plugins", ":source $MYVIMRC<CR>:call dein#install()<CR>")
define_category({"v", "e"}, "+edit")
define_binding("n", {"v", "e", "i"}, "init.fnl", ":e $MYVIMRC/../fnl/dotfiles/init.fnl<CR>")
define_binding("n", {"v", "e", "b"}, "bindings.fnl", ":e $MYVIMRC/../fnl/dotfiles/module/bindings.fnl<CR>")
define_binding("n", {"v", "e", "p"}, "init.vim (plugins)", ":e $MYVIMRC<CR>")
define_binding("n", {"v", "e", "s"}, "settings", ":e $MYVIMRC/../fnl/dotfiles/module/settings.fnl<CR>")
define_category({"q"}, "+quit")
define_binding("n", {"q", "q"}, "quit and save everything", ":wqall<CR>")
define_binding("n", {"q", "r"}, "quit and reload", ":Obsession ~/session.vim<CR>:!start neovide -S ~/session.vim<CR><CR>:wqall<CR>")
define_category({"w"}, "+windows")
define_binding("n", {"w", "h"}, "jump left", "<C-w>h")
define_binding("n", {"w", "j"}, "jump down", "<C-w>j")
define_binding("n", {"w", "k"}, "jump up", "<C-w>k")
define_binding("n", {"w", "l"}, "jump right", "<C-w>l")
define_binding("n", {"w", "y"}, "split left", ":vsplit<CR><ESC>")
define_binding("n", {"w", "u"}, "split down", ":split<CR><C-w>j<ESC>")
define_binding("n", {"w", "i"}, "split up", ":split<CR><ESC>")
define_binding("n", {"w", "o"}, "split right", ":vsplit<CR><C-w>l<ESC>")
define_binding("n", {"w", "="}, "auto resize", "<Plug>(golden_ratio_resize)")
define_category({"b"}, "+buffers")
define_binding("n", {"b", "b"}, "buffers", ":Buffers<CR>")
define_binding("n", {"b", "h"}, "previous", ":bprevious<CR>")
define_binding("n", {"b", "l"}, "next", ":bnext<CR>")
define_binding("n", {"b", "k"}, "first", ":bfirst<CR>")
define_binding("n", {"b", "j"}, "last", ":blast<CR>")
define_binding("n", {"b", "d"}, "delete", ":BD<CR>")
define_category({"f"}, "+file")
define_binding("n", {"f", "r"}, "recent", ":History<CR>")
define_binding("n", {"f", "s"}, "save", ":w<CR>")
define_binding("n", {"f", "f"}, "format", ":CocCommand prettier.formatFile<CR>")
define_category({"k"}, "+kill")
define_binding("n", {"k", "w"}, "window", ":wq<CR>")
define_category({"t"}, "+terminal")
define_binding("n", {"t", "t"}, "Open Terminal", "<ESC>:call v:lua.g.toggle_terminal()<CR>")
define_binding("n", {"t", "n"}, "New Terminal", "<ESC>:call v:lua.g.new_terminal()<CR>")
define_binding("n", {"t", "l"}, "Next Terminal", "<ESC>:call v:lua.g.next_terminal()<CR>")
define_binding("n", {"t", "h"}, "Previous Terminal", "<ESC>:call v:lua.g.previous_terminal()<CR>")
define_category({";"}, "+commentary")
define_binding("n", {";", ";"}, "current line", ":Commentary<CR>")
define_category({" "}, "+easymotion")
define_binding("n", {" ", "f"}, "character", "<Plug>(easymotion-f)")
define_binding("n", {" ", "F"}, "backwards character", "<Plug>(easymotion-F)")
define_binding("n", {" ", "t"}, "before character", "<Plug>(easymotion-t)")
define_binding("n", {" ", "T"}, "backwards after character", "<Plug>(easymotion-T)")
define_binding("n", {" ", "w"}, "word", "<Plug>(easymotion-w)")
define_binding("n", {" ", "W"}, "WORD", "<Plug>(easymotion-W)")
define_binding("n", {" ", "b"}, "backwards to word", "<Plug>(easymotion-b)")
define_binding("n", {" ", "B"}, "backwards to WORD", "<Plug>(easymotion-B)")
define_binding("n", {" ", "e"}, "end of word", "<Plug>(easymotion-e)")
define_binding("n", {" ", "E"}, "end of WORD", "<Plug>(easymotion-E)")
define_category({" ", "g"}, "+back")
define_binding("n", {" ", "g", "e"}, "ge jump backwards to end of word", "<Plug>(easymotion-ge)")
define_binding("n", {" ", "g", "E"}, "gE jump backwards to end of word", "<Plug>(easymotion-ge)")
define_binding("n", {" ", "j"}, "down to line", "<Plug>(easymotion-j)")
define_binding("n", {" ", "k"}, "up to line", "<Plug>(easymotion-k)")
define_binding("n", {" ", "n"}, "jump to search result", "<Plug>(easymotion-n)")
define_binding("n", {" ", "N"}, "jump to previous search result", "<Plug>(easymotion-N)")
define_binding("n", {"J"}, "jump to location", "<plug>(easymotion-overwin-f)")
nvim.g.which_key_map = which_key_map
nvim.call_function("which_key#register", {"<Space>", "g:which_key_map"})
map_silent("n", "gd", "<plug>(coc-definition)")
map_silent("n", "<C-.>", "<plug>(coc-codeaction)")
map_silent("v", "<C-.>", "<plug>(coc-codeaction)")
noremap_silent("n", "gh", ":<C-u>call CocAction('doHover')<CR>")
noremap_silent("v", "<", "<gv")
noremap_silent("v", ">", ">gv")
noremap_silent("v", ";", ":Commentary<CR>")
noremap_silent("v", "<M-q>", "gq")
nvim.set_keymap("t", "<ESC>", "(&filetype == \"fzf\") ? \"<Esc>\" : \"<C-\\><C-n>\"", {expr = true, noremap = true})
noremap_silent("n", "<down>", ":call comfortable_motion#flick(100)<CR>")
noremap_silent("n", "<up>", ":call comfortable_motion#flick(-100)<CR>")
noremap_silent("n", "-", ":Balsamic<CR>")
map_silent("n", "<ESC>", ":noh<CR>:call v:lua.g.hide_terminal()<CR><Plug>(coc-float-hide)")
local function _3_(mode)
  assert((nil ~= mode), ("Missing argument %s on %s:%s"):format("mode", "C:\\Users\\keithsim\\AppData\\Local\\nvim/fnl\\dotfiles\\module\\bindings.fnl", 222))
  return map_silent(mode, "fd", "<Esc>")
end
return core["run!"](_3_, {"n", "i", "t", "c", "v"})