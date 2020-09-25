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
local function _1_(...)
  _0_0["aniseed/local-fns"] = {require = {core = "aniseed.core", util = "dotfiles.util"}}
  return {require("aniseed.core"), require("dotfiles.util")}
end
local _2_ = _1_(...)
local core = _2_[1]
local util = _2_[2]
do local _ = ({nil, _0_0, {{}, nil}})[2] end
local function _3_(path)
  return require(string.gsub(path, ".*\\(.-)\\(.-)\\(.-)%.lua", "%1.%2.%3"))
end
return core["run!"](_3_, util.glob((util["config-path"] .. "/lua/dotfiles/module/*.lua")))