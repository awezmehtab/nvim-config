-- my own statusline if I start disliking lualine :)
local mode_hl = {
    n = "SLNormal",
    i = "SLInsert",
    v = "SLVisual",
    V = "SLVisual",
    ["\22"] = "SLVisual", -- Ctrl-V (block)
    c = "SLCommand",
}

local mode_str = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK",
    c = "COMMAND",
    t = "TERMINAL",
}

local function mode()
    local m = vim.fn.mode()
    local text = mode_str[m] or m
    local hl = mode_hl[m] or "SLNormal"
    return "%#" .. hl .. "#" .. " " .. text .. " " .. "%#StatusLine#"
end

local function left()
    return " " .. vim.fn.expand("%")
end

local function right()
    local ft = vim.bo.filetype ~= "" and vim.bo.filetype or "none"
    local line = vim.fn.line(".")
    local col = vim.fn.col(".")
    local pct = math.floor(line * 100 / vim.fn.line("$") + 0.5)
    return ft
        .. " "
        .. string.format(" %d:%d ", line, col)
        .. string.format(" %d%%%% ", pct) -- '%%%%' -> literal '%'
        .. "%#StatusLine#"
end

-- -G is required to add the function into a namespace so that v.lua can see it
-- and be used where VimScript is expected
function _G.statusline()
    return mode() .. left() .. "%=" .. right()
end

vim.o.statusline = "%!v:lua.left()"
vim.o.statusline = "from vimscript: %F"
vim.o.statusline = "%!v:lua.statusline()"

vim.api.nvim_set_hl(0, "SLNormal", { fg = "#191724", bg = "#31748f" })
vim.api.nvim_set_hl(0, "SLInsert", { fg = "#191724", bg = "#9ccfd8" })
vim.api.nvim_set_hl(0, "SLVisual", { fg = "#191724", bg = "#f6c177" })
vim.api.nvim_set_hl(0, "SLCommand", { fg = "#191724", bg = "#eb6f92" })
