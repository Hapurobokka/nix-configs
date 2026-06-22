require("lze").register_handlers(require('nixCatsUtils.lzUtils').for_cat)
require('lze').register_handlers(require('lzextras').lsp)

require('mini.icons').setup()
require('mini.statusline').setup()
require('mini.starter').setup()
require('mini.extra').setup()

require('oil').setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = true
  },
  columns = {
    "icon",
    "permissions",
    "size",
  },
})

require('blink.cmp').setup({
  keymap = {
    preset = "enter",
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
  },
  completion = {
    list = {
      selection = {
        preselect = true,
        auto_insert = true,
      },
    },
    documentation = { auto_show = true },
  },
  sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
  fuzzy = { implementation = "rust" }
})

require('lze').load({
  {
    "mini.surround",
    event = "DeferredUIEnter",
    for_cat = 'general.always',
    after = function()
      require('mini.surround').setup()
    end,
  },
  {
    "mini.pairs",
    event = "InsertEnter",
    for_cat = 'general.always',
    after = function()
      require('mini.pairs').setup()
    end,
  },
  {
    "mini.pick",
    for_cat = 'general.always',
    cmd = "Pick",
    keys = {
      {"<leader>ff", "<cmd>Pick files<cr>", mode = {"n"}, desc = "Pick files"},
      {"<leader>fr", "<cmd>Pick oldfiles<cr>", mode = {"n"}, desc = "Pick oldfiles"},
      {"<leader>ss", "<cmd>Pick grep_live<cr>", mode = {"n"}, desc = "Grep live"},
      {"<leader>bb", "<cmd>Pick buffers<cr>", mode = {"n"}, desc = "Pick buffers"},
      {
        "<leader>sl",
        "<cmd>Pick lsp scope='document_symbol'<cr>",
        mode = {"n"},
        desc = "Pick LSP symbols"
      },
    },
    after = function()
      require('mini.pick').setup()
    end,
  },
  {
    "fidget.nvim",
    for_cat = 'general.extra',
    event = "DeferredUIEnter",
    after = function()
      require('fidget').setup()
    end,
  },
  {
    "undotree",
    for_cat = 'general.extra',
    cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotreePersistUndo", },
    keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>", mode = { "n" }, desc = "Undo Tree" }, },
    before = function()
      vim.g.undotree_WindowLayout = 1
      vim.g.undotree_SplitWidth = 40
    end,
  },
  {
    "kanagawa.nvim",
    after = function()
      vim.cmd("colorscheme kanagawa")
    end
  },
  {
    "which-key.nvim",
    for_cat = 'general.extra',
    event = "DeferredUIEnter",
    after = function()
      require('which-key').setup({
        preset = "helix"
      })

      require('which-key').add({
        { "<leader>f", group = "[f]ind" },
        { "<leader>f_", hidden = true },
        { "<leader>s", group = "[s]earch" },
        { "<leader>s_", hidden = true },
        { "<leader>b", group = "[b]uffers" },
        { "<leader>b_", hidden = true },
        { "<leader>o", group = "[o]pen" },
        { "<leader>o_", hidden = true },
      })
    end
  },
})
