local config = require("lspconfig")
local dap = require("dap")
local dap_projects = require("nvim-dap-projects")
local dap_ui = require("dapui")
local fidget = require("fidget")
local lsp_format = require("lsp-format")
local lspsaga = require("lspsaga")
local mason = require("mason")
local masonLspconfig = require("mason-lspconfig")
local nvim_dap_virtual_text = require("nvim-dap-virtual-text")
local telescope = require("telescope")
local watchfiles = require("vim.lsp._watchfiles")

mason.setup()
masonLspconfig.setup()
lsp_format.setup()

config.ts_ls.setup({ on_attach = lsp_format.on_attach })
config.omnisharp.setup({ on_attach = lsp_format.on_attach })
config.gdscript.setup({
    cmd = { "ncat", "localhost", "6005" },
    flags = { debounce_text_changes = 500 },
    on_attach =
        lsp_format.on_attach
})
config.rust_analyzer.setup({ on_attach = lsp_format.on_attach })
config.clangd.setup({
    cmd = { "C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/Llvm/x64/bin/clangd.exe" },
    on_attach = lsp_format.on_attach
})

fidget.setup({})
lspsaga.setup({ ui = { winblend = 50, border = "none" }, symbol_in_winbar = { enable = true }, lightbulb = { enable = false }, outline = { win_position = "float", close_after_jump = true } })
watchfiles["_watchfunc"] = function(_, _0, _1)
    return true
end
telescope.load_extension("dap")
dap.defaults.fallback["exception_breakpoints"] = { "rust_panic" }
dap_projects.search_project_config()
nvim_dap_virtual_text.setup()
dap_ui.setup()
vim.fn.sign_define(
    "DapBreakpoint",
    {
        text = "🔴",
        texthl = "DapBreakpointSymbol",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint"
    }
)
vim.fn.sign_define(
    "DapBreakpointRejected",
    {
        text = "🟢",
        texthl = "GruvboxGray",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint"
    }
)
vim.fn.sign_define(
    "DapLogPoint",
    {
        text = "",
        texthl = "GruvboxGray",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint"
    }
)
vim.diagnostic.config({ update_in_insert = false, signs = false })
