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
local noremap = nil
do
  local v_23_0_ = nil
  local function noremap0(mode, from, to)
    return nvim.set_keymap(mode, from, to, {noremap = true})
  end
  v_23_0_ = noremap0
  _0_0["aniseed/locals"]["noremap"] = v_23_0_
  noremap = v_23_0_
end
local noremap_silent = nil
do
  local v_23_0_ = nil
  local function noremap_silent0(mode, from, to)
    return nvim.set_keymap(mode, from, to, {noremap = true, silent = true})
  end
  v_23_0_ = noremap_silent0
  _0_0["aniseed/locals"]["noremap-silent"] = v_23_0_
  noremap_silent = v_23_0_
end
local declare_command = nil
do
  local v_23_0_ = nil
  local function declare_command0(body)
    return nvim.command(("command! " .. body))
  end
  v_23_0_ = declare_command0
  _0_0["aniseed/locals"]["declare-command"] = v_23_0_
  declare_command = v_23_0_
end
local declare_command_with_args = nil
do
  local v_23_0_ = nil
  local function declare_command_with_args0(body)
    return nvim.command(("command! -nargs=+ " .. body))
  end
  v_23_0_ = declare_command_with_args0
  _0_0["aniseed/locals"]["declare-command-with-args"] = v_23_0_
  declare_command_with_args = v_23_0_
end
local is_terminal_window = nil
do
  local v_23_0_ = nil
  local function is_terminal_window0(bufnumber)
    return ((nvim.bo[bufnumber].buftype == "terminal") and (nvim.b[bufnumber].floaterm_window == 1))
  end
  v_23_0_ = is_terminal_window0
  _0_0["aniseed/locals"]["is-terminal-window"] = v_23_0_
  is_terminal_window = v_23_0_
end
local find_terminal_window = nil
do
  local v_23_0_ = nil
  local function find_terminal_window0()
    return core.first(core.filter(is_terminal_window, nvim.fn.range(1, nvim.fn.winnr("$"))))
  end
  v_23_0_ = find_terminal_window0
  _0_0["aniseed/locals"]["find-terminal-window"] = v_23_0_
  find_terminal_window = v_23_0_
end
local hide_terminal = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function hide_terminal0()
      local winnr = find_terminal_window()
      if (winnr > 0) then
        return nvim.command((winnr .. "wincmd q"))
      end
    end
    v_23_0_0 = hide_terminal0
    _0_0["hide-terminal"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["hide-terminal"] = v_23_0_
  hide_terminal = v_23_0_
end
local setup_terminal = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function setup_terminal0()
      nvim.g["floaterm_width"] = (nvim.o.columns - 10)
      nvim.g["floaterm_height"] = (nvim.o.lines - 5)
      return nil
    end
    v_23_0_0 = setup_terminal0
    _0_0["setup-terminal"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["setup-terminal"] = v_23_0_
  setup_terminal = v_23_0_
end
local toggle_terminal = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function toggle_terminal0()
      setup_terminal()
      nvim.o.shell = "pwsh"
      nvim.ex.FloatermToggle()
      nvim.o.shell = "cmd"
      return nil
    end
    v_23_0_0 = toggle_terminal0
    _0_0["toggle-terminal"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["toggle-terminal"] = v_23_0_
  toggle_terminal = v_23_0_
end
local new_terminal = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function new_terminal0()
      setup_terminal()
      nvim.o.shell = "pwsh"
      nvim.ex.FloatermNew()
      nvim.o.shell = "cmd"
      return nil
    end
    v_23_0_0 = new_terminal0
    _0_0["new-terminal"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["new-terminal"] = v_23_0_
  new_terminal = v_23_0_
end
local next_terminal = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function next_terminal0()
      setup_terminal()
      return nvim.ex.FloatermNext()
    end
    v_23_0_0 = next_terminal0
    _0_0["next-terminal"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["next-terminal"] = v_23_0_
  next_terminal = v_23_0_
end
local previous_terminal = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function previous_terminal0()
      setup_terminal()
      return nvim.ex.FloatermPrev()
    end
    v_23_0_0 = previous_terminal0
    _0_0["previous-terminal"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["previous-terminal"] = v_23_0_
  previous_terminal = v_23_0_
end
local okeydokey = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function okeydokey0(args)
      return nvim.command(("!pwsh -Command ok " .. args))
    end
    v_23_0_0 = okeydokey0
    _0_0["okeydokey"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["okeydokey"] = v_23_0_
  okeydokey = v_23_0_
end
local okeydokey_loc = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function okeydokey_loc0(args)
      return nvim.command(("!pwsh -Command ok " .. args .. nvim.ex.resolve("%:p") .. " " .. nvim.ex.line(".") .. " " .. nvim.ex.col(".")))
    end
    v_23_0_0 = okeydokey_loc0
    _0_0["okeydokey-loc"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["okeydokey-loc"] = v_23_0_
  okeydokey_loc = v_23_0_
end
declare_command_with_args("Ok :lua okeydokey(<q-args>)")
return declare_command_with_args("OkLoc :lua okeydokey-loc(<q-args>)")