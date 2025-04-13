-- [nfnl] Compiled from fnl\bindings.fnl by https://github.com/Olical/nfnl, do not edit.
local util = require("util")
local whichkey = require("which-key")
local leap = require("leap")

local function map(mode, from, to)
    return vim.api.nvim_set_keymap(mode, from, to, {})
end
local function map_silent(mode, from, to)
    return vim.api.nvim_set_keymap(mode, from, to, { silent = true })
end
local function noremap(mode, from, to)
    return vim.api.nvim_set_keymap(mode, from, to, { noremap = true })
end
local function noremap_silent(mode, from, to)
    return vim.api.nvim_set_keymap(mode, from, to, { noremap = true, silent = true })
end
local function noremap_silent_expr(mode, from, to)
    return vim.api.nvim_set_keymap(mode, from, to, { noremap = true, silent = true, expr = true })
end

local function hide_terminal()
    return vim.cmd.FloatermHide()
end
util.export("hide_terminal", hide_terminal)
local function setup_terminal()
    vim.g["floaterm_width"] = (vim.o.columns - 10)
    do end
    (vim.g)["floaterm_height"] = (vim.o.lines - 5)
    return nil
end
local function update_terminal()
    return vim.cmd.FloatermUpdate(("--width=" .. vim.g.floaterm_width .. " --height=" .. vim.g.floaterm_height))
end
local function toggle_terminal()
    setup_terminal()
    vim.cmd.FloatermToggle()
    return update_terminal()
end
util.export("toggle_terminal", toggle_terminal)
local function new_terminal()
    return vim.cmd.FloatermNew()
end
util.export("new_terminal", new_terminal)
local function next_terminal()
    vim.cmd.FloatermNext()
    return update_terminal()
end
util.export("next_terminal", next_terminal)
local function previous_terminal()
    vim.cmd.FloatermPrev()
    return update_terminal()
end
util.export("previous_terminal", previous_terminal)


vim.g.mapleader = " "
local config_path = vim.fn.stdpath("config")

whichkey.register({
    v = {
        name = "Vim",
        l = { ":Lazy<CR>", "lazy" },
        m = { ":Mason<CR>", "mason" },
        e = {
            name = "Edit",
            i = { (":e " .. config_path .. "/init.lua<CR>"), "init.lua" },
            b = { (":e " .. config_path .. "/lua/bindings.lua<CR>"), "bindings.lua" },
            p = { (":e " .. config_path .. "/lua/plugins.lua<CR>"), "plugins.lua" },
            s = { (":e " .. config_path .. "/lua/settings.lua<CR>"), "settings.lua" },
            l = { (":e " .. config_path .. "/lua/lsp.lua<CR>"), "lsp.lua" },
            t = { (":e " .. config_path .. "/lua/treesitter.lua<CR>"), "treesitter.lua" },
            u = { (":e " .. config_path .. "/lua/util.lua<CR>"), "util.lua" }
        }
    },
    q = {
        name = "Quit",
        q = { ":FloatermKill!<CR>:wqall!<CR>", "quit and save everything" },
        r = { ":FloatermKill!<CR>:Obsession ~/session.vim<CR>:!start c:/dev/Tools/neovide.exe -- -S ~/session.vim<CR><CR>:wqall!<CR>", "quit and reload" }
    },
    w = {
        name = "Windows",
        h = { "<C-w>h", "jump left" },
        j = { "<C-w>j", "jump down" },
        k = { "<C-w>k", "jump up" },
        l = { "<C-w>l", "jump right" },
        y = { ":vsplit<CR><ESC>", "split left" },
        u = { ":split<CR><C-w>j<ESC>", "split down" },
        i = { ":split<CR><ESC>", "split up" },
        o = { ":vsplit<CR><C-w>l<ESC>", "split right" }
    },
    b = {
        name = "Buffers",
        b = { ":lua require'telescope.builtin'.buffers{}<CR>", "list" },
        h = { "<cmd>BufferPrevious<CR>", "previous" },
        l = { "<cmd>BufferNext<CR>", "next" },
        k = { "<cmd>BufferFirst<CR>", "first" },
        j = { "<cmd>BufferLast<CR>", "last" },
        d = { "<cmd>BufferClose<CR>", "delete" },
        D = { "<cmd>BufferClose!<CR>", "delete without saving" }
    },
    f = {
        name = "Files",
        f = { ":Telescope frecency<CR>", "recent" },
        p = { ":lua require'telescope'.extensions.project.project{}<CR>", "project" },
        e = { ":luafile %<CR>", "eval lua" },
        s = { ":w<CR>", "save" },
        c = { ":cd %:h<CR>", "cd to file" },
    },
    t = {
        name = "Terminal",
        t = { "<ESC>:call v:lua.g.toggle_terminal()<CR>", "Open Terminal" },
        n = { "<ESC>:call v:lua.g.new_terminal()<CR>", "New Terminal" },
        l = { "<ESC>:call v:lua.g.next_terminal()<CR>", "Next Terminal" },
        h = { "<ESC>:call v:lua.g.previous_terminal()<CR>", "Previous Terminal" }
    },
    T = {
        name = "Tab",
        T = { "<ESC>:tabnew<CR>", "New Tab" },
        N = { "<ESC>:tabnext<CR>", "Next Tab" },
        P = { "<ESC>:tabprevious<CR>", "Previous Tab" },
        D = { "<ESC>:tabclose<CR>", "Close Tab" }
    },
    x = {
        name = "teXt",
        i = { "<cmd>Sleuth<CR>", "Autodetect Indent Settings" },
        [";"] = { "<cmd>Commentary<CR>", "Comment current line" }
    },
    l = {
        name = "LSP",
        c = { "<cmd>ClangdSwitchSourceHeader<CR>", "(c++) Switch Header/Source" },
        h = { "<cmd>Lspsaga hover_doc<CR>", "Hover" },
        H = { "<cmd>Lspsaga <cmd>Lspsaga show_cursor_diagnostics<CR>", "Hover Diagnostics" },
        d = { "<cmd>Lspsaga goto_definition<CR>", "Goto Definition" },
        r = { "<cmd>Lspsaga rename<CR>", "Rename" },
        ["."] = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
        n = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic" },
        p = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic" },
        o = { ":lua require'telescope.builtin'.lsp_document_symbols{}<CR>", "Outline" },
        D = { "<cmd>Trouble workspace_diagnostics<CR>", "Diagnostic List" },
        R = { ":LspRestart<CR>", "Restart LSP" }
    },
    d = {
        name = "DAP",
        d = { "<cmd>lua require'telescope'.extensions.dap.configurations{}<CR>", "Start" },
        c = { "<cmd>lua require'dap'.continue()<CR>", "Continue" },
        h = { "<cmd>lua require'dap.ui.widgets'.hover()<CR>", "Hover" },
        j = { "<cmd>lua require'dap'.step_into()<CR>", "Step Into" },
        k = { "<cmd>lua require'dap'.step_out()<CR>", "Step Out" },
        l = { "<cmd>lua require'dap'.step_over()<CR>", "Step Over" },
        u = { "<cmd>lua require'dap'.down()<CR>", "Down" },
        i = { "<cmd>lua require'dap'.up()<CR>", "Up" },
        b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
        t = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle DAP UI" },
        q = { "<cmd>lua require'dap'.close()<CR>", "Close" }
    },
    o = {
        name = "Okeydokey",
        b = { ":!ok build<CR>", "Build Project" },
        g = { ":!ok generate<CR>", "Generate Project Files" },
    },
    p = {
        name = "Perforce",
        e = { ":!p4 edit %<CR>:w!<CR>", "Edit Current File" },
    },
    [":"] = { ":lua require'telescope.builtin'.commands{}<CR>", "Commands" }
}, { prefix = "<leader>" })

vim.g.coq_settings = { ["keymap.recommended"] = false }
noremap_silent_expr("i", "<Esc>", "pumvisible() ? '<C-e><Esc>' : '<Esc>'")
noremap_silent_expr("i", "<C-c>", "pumvisible() ? '<C-e><C-c>' : '<C-c>'")
noremap_silent_expr("i", "<BS>", "pumvisible() ? '<C-e><BS>' : '<BS>'")
noremap_silent_expr("i", "<Down>", "pumvisible() ? '<C-n>' : '<Down>'")
noremap_silent_expr("i", "<Up>", "pumvisible() ? '<C-p>' : '<Up>'")
noremap_silent("v", "<", "<gv")
noremap_silent("v", ">", ">gv")
noremap_silent("v", ";", ":Commentary<CR>")
noremap_silent("v", "<M-q>", "gq")
noremap_silent("t", "<ESC>", "<C-\\><C-n>")
noremap_silent("n", "<down>", ":call comfortable_motion#flick(100)<CR>")
noremap_silent("n", "<up>", ":call comfortable_motion#flick(-100)<CR>")
map_silent("n", "<ESC>", (":noh<CR>" .. ":call v:lua.g.hide_terminal()<CR>"))
leap.add_default_mappings()
