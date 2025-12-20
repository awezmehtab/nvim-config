vim.diagnostic.config({ severity_sort = true })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostics in Quickfix' })
