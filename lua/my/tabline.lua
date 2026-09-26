function _G.nvim_tabline()
    local s = ""
    local handles = vim.api.nvim_list_tabpages()
    for i = 1, vim.fn.tabpagenr("$") do
        local buf = vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
        local name = vim.t[handles[i]].tabname
        if not name then
            name = vim.api.nvim_buf_get_name(buf)
            if vim.bo[buf].buftype == "terminal" and name:match("^term://") then
                name = name:match("//%d+:(.*)$") or name
            else
                name = name:gsub("/+$", "")
                name = name:match("[^/]+$") or name
            end
            if name == "" then
                name = "[No Name]"
            end
        end
        local modified = vim.bo[buf].modified and "+" or ""
        s = s .. "%" .. i .. "T"
        s = s .. (i == vim.fn.tabpagenr() and "%#TabLineSel#" or "%#TabLine#")
        s = s .. " " .. name .. modified .. " "
        s = s .. "%T"
    end
    return s .. "%#TabLineFill#"
end
vim.o.tabline = "%!v:lua.nvim_tabline()"
