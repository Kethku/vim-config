local _0_0 = nil
do
  local name_0_ = "dotfiles.init"
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
    return {require("aniseed.core"), require("aniseed.nvim"), require("dotfiles.util")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {core = "aniseed.core", nvim = "aniseed.nvim", util = "dotfiles.util"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _1_ = _2_(...)
local core = _1_[1]
local nvim = _1_[2]
local util = _1_[3]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "dotfiles.init"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local function _3_(path)
  return require(string.gsub(path, ".*\\(.-)\\(.-)\\(.-)%.lua", "%1.%2.%3"))
end
return core["run!"](_3_, util.glob((util["config-path"] .. "/lua/dotfiles/module/*.lua")))