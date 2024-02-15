local safeRequire = (require("util"))["safe-require"]

vim.o.shellslash = true
local install_path = (vim.fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim")
if (vim.fn.empty(vim.fn.glob(install_path)) > 0) then
  vim.fn.system({ git = "clone", ["https://github.com/savq/paq-nvim"] = install_path })
end

vim.cmd("packadd paq-nvim")
safeRequire("plugins")
safeRequire("settings")
safeRequire("lsp")
safeRequire("treesitter")
safeRequire("bindings")
safeRequire("resize")
