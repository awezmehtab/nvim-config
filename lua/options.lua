local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.autocomplete = true
opt.winborder = "rounded"
opt.signcolumn = "yes"

opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { eob = " ", vert = "│" }

opt.splitbelow = true

vim.filetype.add({
    extension = {
        jimple = "java"
    }
})
