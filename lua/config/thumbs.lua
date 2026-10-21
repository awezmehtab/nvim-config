local script = vim.fn.stdpath("config") .. "/bin/thumb"
if vim.fn.executable(script) == 0 then
    return
end

vim.api.nvim_create_autocmd({ "WinNew", "BufWinEnter", "TabEnter" }, {
    pattern = { "*.pdf", "*.mp4", "*.mkv", "*.webm", "*.mov", "*.avi" },
    callback = function(ev)
        local image = require("image")
        if not image.is_enabled() then
            return
        end
        local win = vim.api.nvim_get_current_win()
        local path = vim.api.nvim_buf_get_name(ev.buf)
        local function show(r)
            if r.code == 0 and vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == ev.buf then
                image.hijack_buffer(vim.trim(r.stdout), win, ev.buf)
            end
        end
        local cached = vim.system({ script, "-c", path }):wait()
        if cached.code == 0 then
            return show(cached)
        end
        vim.bo[ev.buf].modifiable = true
        vim.api.nvim_buf_set_lines(ev.buf, 0, -1, true, {})
        vim.bo[ev.buf].modifiable = false
        vim.bo[ev.buf].buftype = "nowrite"
        vim.system({ script, path }, {}, vim.schedule_wrap(show))
    end,
})
