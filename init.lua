vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.autocomplete = true
vim.o.winborder = "rounded"

vim.pack.add {
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/rose-pine/neovim"
}

require("rose-pine").setup({
    styles = {
        italic = false,
        transparency = true
    }
})

vim.cmd("colorscheme rose-pine")

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			}
		}
	}
})

vim.lsp.enable({ "clangd" , "lua_ls" })
