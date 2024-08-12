-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local req = (require("util"))["safe-require"]
local execute = vim.api.nvim_command
do
  local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
  local fs_stat = (vim.uv or vim.loop).fs_stat
  local needs_cloned = not fs_stat(lazypath)
  if needs_cloned then
    local git_output = vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
    print(git_output)
  else
  end
  do end (vim.opt.rtp):prepend(lazypath)
end
req("plugins")
req("settings")
req("lsp")
req("treesitter")
req("bindings")
req("resize")
return {}
