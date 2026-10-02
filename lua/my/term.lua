local M = { name = ":shell", bufnr = nil, prevwinid = nil }

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function(args)
        local win = vim.fn.bufwinid(args.buf)
        if win == -1 then
            return
        end
        vim.wo[win].statusline = " "
    end,
})

vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
        if vim.api.nvim_get_current_buf() ~= M.bufnr then
            M.prevwinid = vim.api.nvim_get_current_win()
        end
    end,
})

local function jump_to_shell()
    if not M.bufnr or not vim.api.nvim_buf_is_valid(M.bufnr) then
        local stale = vim.fn.bufnr(M.name)
        if stale ~= -1 then
            vim.api.nvim_buf_delete(stale, { force = true })
        end
        vim.cmd("tab term")
        M.bufnr = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_name(M.bufnr, M.name)
        vim.bo[M.bufnr].buflisted = false
    else
        local wins = vim.fn.win_findbuf(M.bufnr)
        if #wins == 0 then
            vim.cmd("tab sb " .. M.bufnr)
        else
            vim.api.nvim_set_current_win(wins[1])
        end
    end
    vim.cmd("startinsert")
end

local function jump_back()
    if not (M.prevwinid and vim.api.nvim_win_is_valid(M.prevwinid)) then
        vim.notify("previous window doesn't exist", vim.log.levels.WARN)
        return
    end
    local win = vim.api.nvim_get_current_win()
    local tab = vim.api.nvim_win_get_tabpage(win)
    if #vim.api.nvim_tabpage_list_wins(tab) == 1 then
        vim.cmd("tabclose")
    end
    vim.api.nvim_set_current_win(M.prevwinid)
end

local function toggle()
    if vim.api.nvim_get_current_buf() ~= M.bufnr then
        jump_to_shell()
    else
        jump_back()
    end
end

M.toggle = toggle
return M
