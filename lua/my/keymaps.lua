local map = vim.keymap.set

map("n", "-", "<cmd>Oil<CR>", { desc = "File explorer" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste system clipboard" })

-- pickers (fzf-lua)
map("n", "<leader>fo", "<cmd>FzfLua<CR>", { desc = "Open FzfLua" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Buffers" })
map("n", "<leader>f/", "<cmd>FzfLua blines<CR>", { desc = "Buffer Fuzzy Find" })
map("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fh", "<cmd>FzfLua helptags<CR>", { desc = "Help" })
map("n", "<leader>fr", "<cmd>FzfLua resume<CR>", { desc = "Resume" })
map("n", "<leader>fc", function()
    require("my.cc_sessions").pick()
end, { desc = "Claude sessions" })
map("n", "<leader>fu", "<cmd>FzfLua undotree<CR>", { desc = "Undotree" })

-- toggles
map("n", "<leader>ti", function()
    local image = require("image")
    image[image.is_enabled() and "disable" or "enable"]()
end, { desc = "Toggle inline images" })

-- tabs
map("n", "<leader>T", function()
    local name = vim.fn.input("Tab name: ")
    if name ~= "" then
        vim.t.tabname = name
        vim.cmd.redrawtabline()
    end
end, { desc = "Rename tab" })
local function switch_tab(cmd)
    return function()
        vim.cmd(cmd)
        vim.cmd(vim.bo.buftype == "terminal" and "startinsert" or "stopinsert")
    end
end
map({ "n", "t" }, "<C-Tab>", switch_tab("tabnext"))
map({ "n", "t" }, "<C-S-Tab>", switch_tab("tabprevious"))

-- window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- scroll
map("t", "<C-f>", "<PageDown>")
map("t", "<C-b>", "<PageUp>")

-- terminal
local term = require("my.term")
map({ "t", "i", "v", "n" }, "<C-s>", term.toggle)
