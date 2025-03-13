require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/snippets/" } })

return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.3.0",
        build = "make install_jsregexp",
    },
}
