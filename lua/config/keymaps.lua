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
map("n", "<leader>fc", function() require("config.cc_sessions").pick() end, { desc = "Claude sessions" })
map("n", "<leader>fu", "<cmd>FzfLua undotree<CR>", { desc = "Undotree" })
map("n", "<A-c>", function()
    require("fzf-lua").fzf_exec("fd -H -t d", {
        cwd = vim.env.HOME,
        prompt = "~/",
        actions = {
            default = function(s)
                vim.cmd.cd(vim.fs.joinpath(vim.env.HOME, s[1]))
            end,
        },
        preview = "ls -A --color=always {}",
        winopts = {
            height = 0.5,
            width = 0.6,
            preview = { layout = "horizontal", horizontal = "right:40%" },
        },
    })
end, { desc = "cd (tab)" })

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
map({ "n", "t" }, "<C-Tab>", "<Cmd>tabnext<CR>")
map({ "n", "t" }, "<C-S-Tab>", "<Cmd>tabprevious<CR>")

-- window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("t", "<C-h>", "<Cmd>wincmd h<CR>")
map("t", "<C-j>", "<Cmd>wincmd j<CR>")
map("t", "<C-k>", "<Cmd>wincmd k<CR>")
map("t", "<C-l>", "<Cmd>wincmd l<CR>")
map("t", "<C-\\><C-h>", "<C-h>")
map("t", "<C-\\><C-j>", "<C-j>")
map("t", "<C-\\><C-k>", "<C-k>")
map("t", "<C-\\><C-l>", "<C-l>")

-- scroll
map("t", "<C-f>", "<PageDown>")
map("t", "<C-b>", "<PageUp>")
map("t", "<C-\\><C-f>", "<C-f>")
map("t", "<C-\\><C-b>", "<C-b>")

-- terminal
local term = require("config.term")
map({ "t", "i", "v", "n" }, "<C-s>", term.toggle)
map("t", "<C-\\><C-s>", "<C-s>")
map("t", "<A-Esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })
