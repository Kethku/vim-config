-- [nfnl] Compiled from lua\util.fnl by https://github.com/Olical/nfnl, do not edit.
local Util = {}
Util["safe-require"] = function(name)
  local ok_3f, val_or_err = pcall(require, name)
  if not ok_3f then
    return print(("Plugin error from " .. name .. ": " .. val_or_err))
  else
    return nil
  end
end
g = {}
Util.export = function(name, variable)
  g[name] = variable
  return nil
end
Util["set-option"] = function(option)
  return vim.cmd(("set " .. option))
end
Util["declare-command"] = function(body)
  return vim.api.nvim_command(("command! " .. body))
end
Util["declare-command-with-args"] = function(body)
  return vim.api.nvim_command(("command! -nargs=+ " .. body))
end
Util["contains?"] = function(xs, x)
  local found = false
  for _, value in pairs(xs) do
    if found then break end
    if (value == x) then
      table.insert(found, true)
    else
    end
  end
  return found
end
return Util
