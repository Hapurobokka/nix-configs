vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { noremap = true, desc = 'LSP definition' })
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { noremap = true, desc = 'LSP declaration' })

vim.keymap.set("n", "<leader>of", "<cmd>Oil<cr>", { noremap = true, desc = 'Open Oil' })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { noremap = true, desc = 'Delete buffer' })
