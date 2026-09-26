vim.api.nvim_create_autocmd("TermOpen", {
    callback = function(args)
        local win = vim.fn.bufwinid(args.buf)
        if win == -1 then
            return
        end
        vim.wo[win].statusline = " "
    end,
})

vim.api.nvim_create_autocmd("TermRequest", {
    callback = function(args)
        local seq = args.data.sequence
        if not seq then
            return
        end
        if seq:match("^\027%]9;") then
            io.stdout:write(seq .. args.data.terminator)
        end
    end,
})
