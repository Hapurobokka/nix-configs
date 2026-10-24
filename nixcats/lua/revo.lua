vim.filetype.add({
  extension = {
    rv = "revo",
    revo = "revo",
  },
})

vim.lsp.config("revo", {
  cmd = { "revo", "lsp" },
  filetypes = { "revo" },
  root_markers = { "lib.json", "exe.json", ".git" },
})

vim.lsp.enable("revo")
vim.treesitter.language.register("revo", "revo")
