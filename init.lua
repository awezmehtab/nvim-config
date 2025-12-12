require("config.lazy")
for i = 0, 15 do
    vim.g[("terminal_color_%u"):format(i)] = nil
end
