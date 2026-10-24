vim.api.nvim_create_autocmd('FileType', {
  desc = "Changes the indent size to 2 in certain files",
  pattern = {
    "css",
    "haskell",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "lua",
    "nim",
    "nix",
    "svelte",
    "toml",
    "typescript",
    "typescriptreact",
    "xml",
    "revo"
  },
  callback = function(ev)
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
  end
})

local fts = {
  "lua",
  "nix",
  "nim",
  "rust",
  "c",
  "cpp",
  "gdscript",
  "python",
  "ruby",
  "yaml",
  "revo",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = fts,
  callback = function()
    vim.treesitter.start()
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    if vim.bo.filetype == "ruby" then
      vim.opt_local.indentkeys:remove(".")
    end
  end,
})
