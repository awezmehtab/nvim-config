vim.pack.add({
    "https://github.com/rose-pine/neovim",
})

local groups = {
    StatusLineTerm = { link = "StatusLine", inherit = false },
    StatusLineTermNC = { link = "StatusLineNC", inherit = false },
}

-- fixing DiffView colors
local diffview_links = {
    Normal = "Normal",
    NonText = "NonText",
    CursorLine = "CursorLine",
    WinSeparator = "WinSeparator",
    SignColumn = "Normal",
    StatusLine = "StatusLine",
    StatusLineNC = "StatusLineNC",
    EndOfBuffer = "EndOfBuffer",
    FilePanelFileName = "Normal",
}
for from, to in pairs(diffview_links) do
    groups["Diffview" .. from] = { link = to, inherit = false }
end

require("rose-pine").setup({
    styles = { italic = true, transparency = true },
    highlight_groups = groups,
})
vim.cmd("colorscheme rose-pine")
