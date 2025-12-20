vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.asm",
    command = "set filetype=fasm",
})

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.cmd("startinsert")
    end,
})
