vim.g.editorconfig = true

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.expandtab = true    -- pressing <Tab> inserts a "\t" byte?
opt.shiftwidth = 4      -- how much to shift on <<, >> etc.
opt.softtabstop = -1    -- pressing <Tab>/<BS> shifts how much?
opt.tabstop = 4         -- how many cols a "\t" takes up
opt.winborder = "rounded"
opt.signcolumn = "yes"
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { eob = " ", vert = "│", fold = " " }
opt.splitright = true
opt.splitbelow = true
opt.undofile = true
opt.mouse = "a"
opt.tabclose = "uselast"
