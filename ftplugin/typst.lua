if not vim.g.typst_preview_setup then
    require("typst-preview").setup()
    vim.g.typst_preview_setup = true
end

local map = vim.keymap.set
map("n", "<leader>tp", "<cmd>TypstPreview<CR>", { buffer = true, desc = "Typst preview" })
