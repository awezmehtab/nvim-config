-- nvim terminal emulator swallows OSC sequences which send notifications:
-- 9 (iTerm2), 99 (kitty), 777 (rxvt, foot, ghostty)
-- manually passing them through. can add more as required
local passthrough = { ["9"] = true, ["99"] = true, ["777"] = true }

local group = vim.api.nvim_create_augroup("notifications", { clear = true })

vim.g.focused = true
vim.api.nvim_create_autocmd({ "FocusGained", "FocusLost" }, {
    group = group,
    callback = function(args)
        vim.g.focused = args.event == "FocusGained"
    end,
})

-- 9;4 is a progress bar, not a notification, and is always let through
local function is_notification(seq)
    return (seq:match("^\027%]9;") and not seq:match("^\027%]9;4;"))
        or seq:match("^\027%]99;")
        or seq:match("^\027%]777;notify;")
end

vim.api.nvim_create_autocmd("TermRequest", {
    group = group,
    callback = function(args)
        local seq = args.data.sequence
        if not passthrough[seq:match("^\027%](%d+);")] then
            return
        end
        local viewing = vim.g.focused
            and args.buf == vim.api.nvim_get_current_buf()
        if not (viewing and is_notification(seq)) then
            vim.api.nvim_ui_send(seq .. args.data.terminator)
        end
    end,
})
