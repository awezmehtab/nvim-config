-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "/home/awez/learn/codef/*.cpp",
    callback = function(args)
        local bufnr = args.buf
        local filepath = vim.api.nvim_buf_get_name(bufnr)
        local num, prob = filepath:match("codef/(%d+)/([A-Z])%.cpp")

        vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, {
            "/*",
            " * Author: awez_mehtab",
            " * Problem: " .. num .. prob,
            " * Time: " .. os.date("%Y-%m-%d %H:%M"),
            " */",
            "#include <bits/stdc++.h>",
            "using namespace std;",
            "",
            "typedef long long ll;",
            "",
            "int main() {",
            "    ll t;",
            "    cin >> t;",
            "",
            "    while (t--) {",
            "        ",
            "    }",
            "}",
        })
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.asm",
    command = "set filetype=fasm",
})
