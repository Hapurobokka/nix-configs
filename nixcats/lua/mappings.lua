vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { noremap = true, desc = 'LSP definition' })
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { noremap = true, desc = 'LSP declaration' })

vim.keymap.set({ "i", "s" }, "<C-f>", function()
  if vim.snippet.active({ direction = 1 }) then
    return "<Cmd>lua vim.snippet.jump(1)<CR>"
  end
  return "<C-f>"
end, { expr = true, silent = true, desc = "Jump to next snippet placeholder" })

vim.keymap.set("n", "<leader>of", "<cmd>Oil<cr>", { noremap = true, desc = 'Open Oil' })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { noremap = true, desc = 'Delete buffer' })
