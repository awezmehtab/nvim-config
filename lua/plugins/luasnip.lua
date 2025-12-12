require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/snippets/" } })

local ls = require("luasnip")

vim.keymap.set({ "i" }, "<C-n>", function()
    ls.expand()
end, { silent = true, desc = "Expand/Go ahead in the snippet" })

vim.keymap.set({ "i", "s" }, "<C-n>", function()
    if not ls.in_snippet() then
        vim.notify("Not in snippet", vim.log.ERROR, {})
    end
    print("Hello")
    if ls.jumpable(1) then
        ls.jump(1)
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-p>", function()
    if not ls.in_snippet() then
        print("Not in a snippet")
    end
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true, desc = "Jump to previous place in snippet" })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true, desc = "Select snippet" })

return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.3.0",
        build = "make install_jsregexp",
    },
}
