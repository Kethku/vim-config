local _0_0 = nil
do
  local name_23_0_ = "dotfiles.init"
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
  _0_0["aniseed/local-fns"] = {require = {core = "aniseed.core", mapping = "aniseed.mapping", util = "dotfiles.util"}}
  return {require("aniseed.core"), require("aniseed.mapping"), require("dotfiles.util")}
end
local _2_ = _1_(...)
local core = _2_[1]
local mapping = _2_[2]
local util = _2_[3]
do local _ = ({nil, _0_0, nil})[2] end
local function _3_(path)
  return require(string.gsub(path, ".*\\(.-)\\(.-)\\(.-)%.lua", "%1.%2.%3"))
end
core["run!"](_3_, util.glob((util["config-path"] .. "/lua/dotfiles/module/*.lua")))
return mapping.init()