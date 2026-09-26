vim.g.editorconfig = true

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = -1
opt.splitright = true -- i like my vsplits on right
opt.tabstop = 4
opt.winborder = "rounded"
opt.signcolumn = "yes"
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { eob = " ", vert = "│" }
opt.splitbelow = true
opt.undofile = true
opt.mouse = "a"
opt.tabclose = "uselast"
