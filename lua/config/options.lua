local opt = vim.opt

-- Inherit cursor from the terminal, if the NVIM_TERMINAL_CURSOR is set to "true"
local nvim_cursor = os.getenv("NVIM_TERMINAL_CURSOR")
if nvim_cursor == "true" then
    opt.guicursor = ""
end

-- indentation is important
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- must needed to jump easily
opt.number = true
opt.relativenumber = true
-- [[ Setting options ]]
-- See `:help opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    opt.clipboard = "unnamedplus"
end)

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ff0000", bg = "#00ff00" })

-- It's better if the whole line doesn't have a background
vim.o.cursorline = false -- or false if you want it off
vim.cmd("hi! CursorLine guibg=NONE ctermbg=NONE")

opt.fillchars = { eob = " ", vert = "│" }
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "NONE", fg = "NONE" })

local diagnostics_visible = true
vim.keymap.set("n", "<leader>Q", function()
    if diagnostics_visible then
        vim.diagnostic.hide()
        diagnostics_visible = false
    else
        vim.diagnostic.show()
        diagnostics_visible = true
    end
end, { desc = "Toggle diagnostics" })

opt.textwidth = 80

vim.filetype.add({
    extension = {
        scm = "racket",
    },
})

vim.opt.termguicolors = true
