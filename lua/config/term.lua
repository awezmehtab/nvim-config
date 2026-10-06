local group = vim.api.nvim_create_augroup("my_term", { clear = true })

local function autocmd(event, callback)
    vim.api.nvim_create_autocmd(event, { group = group, callback = callback })
end

autocmd("TermOpen", function(args)
    if args.buf == vim.api.nvim_get_current_buf() then
        vim.wo.statusline = " "
        vim.cmd.startinsert()
    end
end)

-- each terminal resumes the mode it was left in
autocmd("WinLeave", function()
    if vim.bo.buftype == "terminal" then
        vim.b.term_insert = vim.fn.mode() == "t"
    end
end)
autocmd({ "WinEnter", "BufEnter" }, function()
    if vim.bo.buftype == "terminal" then
        vim.cmd(vim.b.term_insert == false and "stopinsert" or "startinsert")
    end
end)

-- zsh's clear_screen widget sends this; drop the cleared prompts' marks
local prompt_ns = vim.api.nvim_create_namespace("nvim.terminal.prompt")
autocmd("TermRequest", function(args)
    if args.data.sequence ~= "\027]7777;clear" then
        return
    end
    local rows = math.huge
    for _, win in ipairs(vim.fn.win_findbuf(args.buf)) do
        rows = math.min(rows, vim.api.nvim_win_get_height(win))
    end
    local top = math.max(0, vim.api.nvim_buf_line_count(args.buf) - rows)
    vim.api.nvim_buf_clear_namespace(args.buf, prompt_ns, top, -1)
end)

-- :shell, a scratch terminal toggled from anywhere
local M = {}
local prevwin

local function find_shell()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.b[buf].shell then
            return buf
        end
    end
end

autocmd("WinLeave", function()
    if not vim.b.shell then
        prevwin = vim.api.nvim_get_current_win()
    end
end)

local function open_shell()
    local shell = find_shell()
    if not shell then
        vim.cmd("tab term")
        vim.b.shell = true
        vim.bo.buflisted = false
        vim.api.nvim_buf_set_name(0, ":shell")
        return
    end
    local win = vim.fn.win_findbuf(shell)[1]
    if win then
        vim.api.nvim_set_current_win(win)
    else
        vim.cmd("tab sbuffer " .. shell)
    end
end

local function leave_shell()
    if not (prevwin and vim.api.nvim_win_is_valid(prevwin)) then
        vim.notify("previous window doesn't exist", vim.log.levels.WARN)
        return
    end
    local alone = #vim.api.nvim_tabpage_list_wins(0) == 1
    if alone and #vim.api.nvim_list_tabpages() > 2 then
        vim.cmd.tabclose()
    end
    vim.api.nvim_set_current_win(prevwin)
end

function M.toggle()
    if vim.b.shell then
        leave_shell()
    else
        open_shell()
    end
end

return M
