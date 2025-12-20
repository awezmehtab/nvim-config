local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Inherit cursor from the terminal, if the NVIM_TERMINAL_CURSOR is set to "true"
local nvim_cursor = os.getenv("NVIM_TERMINAL_CURSOR")
if nvim_cursor == "true" then
    opt.guicursor = ""
end

--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
    opt.clipboard = "unnamedplus"
end)

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 10
opt.cursorline = false

vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ff0000", bg = "#00ff00" })
vim.cmd("hi! CursorLine guibg=NONE ctermbg=NONE")
opt.fillchars = { eob = " ", vert = "│" }
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "NONE", fg = "NONE" })
