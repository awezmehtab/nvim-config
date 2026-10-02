-- nvim terminal emulator swallows OSC sequences, these are for notifications:
-- 9    iTerm2 notifications, and progress bars
-- 99   kitty notifications
-- 777  rxvt, foot, ghostty notifications
-- we're manually making them passthrough. can add more as per requirement
local passthrough = { ["9"] = true, ["99"] = true, ["777"] = true }

-- don't want notifications to come when I'm looking at the terminal buffer
vim.g.my_focused = true
local focus = vim.api.nvim_create_augroup("my_focus", { clear = true })
vim.api.nvim_create_autocmd("FocusLost", {
    group = focus,
    callback = function()
        vim.g.my_focused = false
    end,
})
vim.api.nvim_create_autocmd("FocusGained", {
    group = focus,
    callback = function()
        vim.g.my_focused = true
    end,
})

-- 9;4 is a progress bar, not a notification, and is always let through
local function is_notification(seq)
    return (seq:match("^\027%]9;") and not seq:match("^\027%]9;4;"))
        or seq:match("^\027%]99;")
        or seq:match("^\027%]777;notify;")
end
local function viewing(buf)
    return vim.g.my_focused and vim.api.nvim_win_get_buf(0) == buf
end

vim.api.nvim_create_autocmd("TermRequest", {
    group = vim.api.nvim_create_augroup("my_osc_passthrough", { clear = true }),
    callback = function(args)
        local seq = args.data.sequence
        local code = seq and seq:match("^\027%](%d+);")
        if not (code and passthrough[code]) then return end
        if is_notification(seq) and viewing(args.buf) then return end
        vim.api.nvim_ui_send(seq .. args.data.terminator)
    end,
})
