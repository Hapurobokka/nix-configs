require("lze").register_handlers(require('nixCatsUtils.lzUtils').for_cat)
require('lze').register_handlers(require('lzextras').lsp)

-- Plugins que siempre queremos cargados
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

-- Plugins que queremos cargados de forma particular
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
    "mini.jump",
    event = "DeferredUIEnter",
    for_cat = 'general.always',
    after = function()
      require('mini.jump').setup()
    end,
  },
  {
    "mini.jump2d",
    event = "DeferredUIEnter",
    for_cat = 'general.always',
    after = function()
      require('mini.jump2d').setup()
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
    "markview.nvim",
    for_cat = 'mdPlugins'
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
    "jj.nvim",
    for_cat = 'general.extra',
    keys = {
      { "<leader>ojj", "<cmd>J log<cr>", mode = {"n"}, desc = "Open JJ log" },
      { "<leader>ojs", "<cmd>J status<cr>", mode = {"n"}, desc = "Open JJ status" },
      { "<leader>ojd", "<cmd>J describe<cr>", mode = {"n"}, desc = "Describe current commit" },
    },
    after = function()
      require("jj").setup({})
    end
  },
  {
    "claudecode.nvim",
    for_cat = 'general.extra',
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSelectModel",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeStatus",
      "ClaudeCodeStart",
      "ClaudeCodeStop",
      "ClaudeCodeOpen",
      "ClaudeCodeClose",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
      "ClaudeCodeCloseAllDiffs",
    },
    keys = {
      { "<leader>a", nil, desc = "[a]I" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
    after = function()
      require("claudecode").setup({})
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
        { "<leader>oj", group = "[j]ujutsu" },
        { "<leader>oj_", hidden = true },
      })
    end
  },
  {
    "gitsigns.nvim",
    for_cat = "gitPlugins",
    after = function()
      require('gitsigns').setup({})
    end
  }
})
