local lualine = require("lualine")
local telescope = require("telescope")
local noice = require("noice")
local notify = require("notify")
local configLocal = require("config-local")
local autocmd = vim.api.nvim_create_autocmd

local util = require("util")

vim.cmd("filetype plugin indent on")
vim.cmd("autocmd BufEnter * silent! lcd &:p:h")
vim.cmd("autocmd FileType markdown setlocal spell")
vim.cmd("autocmd FileType markdown set textwidth=60")
vim.cmd("autocmd BufNewFile,BufRead *.vert,*.frag set filetype=glsl")

-- Config Local
configLocal.setup({
    lookup_parents = true,
})

-- LuaLine
lualine.setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = {
            left = "",
            right = ""
        },
        section_separators = {
            left = "\238\130\180",
            right = "\238\130\182"
        },
        always_divide_middle = true
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
    }
})

-- Noice
noice.setup({
    presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
    },
})

local stages = require("notify.stages.fade_in_slide_out")("top_down")
notify.setup({
    render = "compact",
    stages = {
        function(...)
          local opts = stages[1](...)
          if opts then
            opts.border = "none"
            opts.row = opts.row + 1
          end
          return opts
        end,
        unpack(stages, 2),
    },
})

-- Markdown
vim.g.markdown_fenced_languages = { "javascript", "typescript", "js=javascript" }
vim.g.vim_markdown_folding_disabled = 1

-- Terminal
vim.cmd("autocmd FileType floaterm setlocal winblend=10")
vim.g.floaterm_position = "center"
vim.g.floaterm_shell = "pwsh"
vim.g.floaterm_borderchars = "        "
vim.g.floaterm_title = ""
vim.cmd("FloatermNew --silent")

-- Telescope
local temp_showtabline
local temp_laststatus

function _G.global_telescope_find_pre()
  temp_showtabline = vim.o.showtabline
  temp_laststatus = vim.o.laststatus
  vim.o.showtabline = 0
  vim.o.laststatus = 0
end

function _G.global_telescope_leave_prompt()
  vim.o.laststatus = temp_laststatus
  vim.o.showtabline = temp_showtabline
end

vim.cmd([[
  augroup MyAutocmds
    autocmd!
    autocmd User TelescopeFindPre lua global_telescope_find_pre()
    autocmd FileType TelescopePrompt autocmd BufLeave <buffer> lua global_telescope_leave_prompt()
  augroup END
]])

local function normalize_path(path)
  return path:gsub("\\", "/")
end

local function normalize_cwd()
  return normalize_path(vim.loop.cwd()) .. "/"
end

local function is_subdirectory(cwd, path)
  return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
end

local function split_filepath(path)
  local normalized_path = normalize_path(path)
  local normalized_cwd = normalize_cwd()
  local filename = normalized_path:match("[^/]+$")

  if is_subdirectory(normalized_cwd, normalized_path) then
    local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
    return stripped_path, filename
  else
    local stripped_path = normalized_path:sub(1, -(#filename + 1))
    return stripped_path, filename
  end
end

local function path_display(_, path)
  local stripped_path, filename = split_filepath(path)
  if filename == stripped_path or stripped_path == "" then
    return filename
  end
  return string.format("%s ~ %s", filename, stripped_path)
end

telescope.setup({ 
    defaults = { 
        border = false, 
        layout_strategy = "horizontal", 
        layout_config = {
            width = 0.999,
            height = 0.999,
        },
        sorting_strategy = "ascending",
        path_display = path_display
    } 
})
telescope.load_extension("frecency")

-- Oil
-- helper function to parse output
local function parse_output(proc)
  local result = proc:wait()
  local ret = {}
  if result.code == 0 then
    for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
      -- Remove trailing slash
      line = line:gsub("/$", "")
      ret[line] = true
    end
  end
  return ret
end

-- build git status cache
local function new_git_status()
  return setmetatable({}, {
    __index = function(self, key)
      local ignore_proc = vim.system(
        { "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
        {
          cwd = key,
          text = true,
        }
      )
      local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
        cwd = key,
        text = true,
      })
      local ret = {
        ignored = parse_output(ignore_proc),
        tracked = parse_output(tracked_proc),
      }

      rawset(self, key, ret)
      return ret
    end,
  })
end
local git_status = new_git_status()

-- Clear git status cache on refresh
local refresh = require("oil.actions").refresh
local orig_refresh = refresh.callback
refresh.callback = function(...)
  git_status = new_git_status()
  orig_refresh(...)
end

require("oil").setup({
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name, bufnr)
      local dir = require("oil").get_current_dir(bufnr)
      local is_dotfile = vim.startswith(name, ".") and name ~= ".."
      -- if no local directory (e.g. for ssh connections), just hide dotfiles
      if not dir then
        return is_dotfile
      end
      -- dotfiles are considered hidden unless tracked
      if is_dotfile then
        return not git_status[dir].tracked[name]
      else
        -- Check if file is gitignored
        return git_status[dir].ignored[name]
      end
    end,
  },
})

-- Neovide
vim.g.neovide_refresh_rate = 140
vim.g.neovide_scroll_animation_length = 0.2
vim.g.neovide_remember_window_size = true
vim.g.neovide_opacity = 1.
vim.g.neovide_floating_corner_radius = 0.33
vim.g.neovide_cursor_trail_size = 0.7
vim.g.neovide_cursor_animation_length = 0.150
vim.g.neovide_title_background_color = string.format(
    "%x",
    vim.api.nvim_get_hl(0, {id=vim.api.nvim_get_hl_id_by_name("Normal")}).bg
)
vim.g.experimental_layer_grouping = true

-- Completions
vim.g.coq_settings = { auto_start = "shut-up" }

-- Options
vim.o.winblend = 20
vim.o.pumblend = 20
vim.o.ve = "block"
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.timeoutlen = 500
vim.o.textwidth = 120
vim.o.conceallevel = 3
vim.o.signcolumn = "auto"
vim.o.number = false
vim.o.laststatus = 3
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmode = false
vim.o.hidden = true
vim.o.wrap = false
vim.o.splitkeep = "screen"
vim.o.mousemodel = "extend"
vim.o.autochdir = true
vim.cmd([[
  " Use persistent history.
  if !isdirectory("C:/dev/Undo")
      call mkdir("C:/dev/Undo", "", 0700)
  endif
  set undodir=C:/dev/Undo
  set undofile
]])

