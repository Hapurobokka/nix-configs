_: {
  vim.keymaps = [
    {
      action = ":Pick spellsuggest<cr>";
      key = "z=";
      mode = "n";
      silent = true;
      desc = "Trigger spell suggestions";
    }
    {
      action = ":Pick grep_live<cr>";
      key = "<leader>sg";
      mode = "n";
      silent = true;
      desc = "Grep in all files";
    }
    {
      action = ":e ~/nix-configs/nvf/<cr>";
      key = "<leader>fnd";
      mode = "n";
      silent = true;
      desc = "Open NVF config";
    }
    {
      action = ":Pick files<cr>";
      key = "<leader>ff";
      mode = "n";
      silent = true;
      desc = "Open files";
    }
    {
      action = ":Pick buffers<cr>";
      key = "<leader>bb";
      mode = "n";
      silent = true;
      desc = "Open buffers";
    }
    {
      action = ":Pick diagnostic<cr>";
      key = "<leader>xx";
      mode = "n";
      silent = true;
      desc = "Open diagnostics";
    }
    {
      action = ":Pick oldfiles<cr>";
      key = "<leader>fr";
      mode = "n";
      silent = true;
      desc = "Open recent files";
    }
    {
      action = ":Pick lsp scope='document_symbol'<cr>";
      key = "<leader>ls";
      mode = "n";
      silent = true;
      desc = "Show lsp symbols";
    }
    {
      action = ":lua MiniFiles.open()<cr>";
      key = "<leader>e";
      mode = "n";
      silent = true;
      desc = "Open files";
    }
    {
      action = ":lua MiniBufremove.delete()<cr>";
      key = "<leader>bd";
      mode = "n";
      silent = true;
      desc = "Delete buffer";
    }
    {
      action = "%bd|edit #|normal'<cr>";
      key = "<leader>bw";
      mode = "n";
      silent = true;
      desc = "Delete all other buffers";
    }
    {
      action = ":split<cr>";
      key = "<leader>ws";
      mode = "n";
      silent = true;
      desc = "Split window";
    }
    {
      action = ":vsplit<cr>";
      key = "<leader>wv";
      mode = "n";
      silent = true;
      desc = "Vertically split window";
    }
    {
      action = ":quit<cr>";
      key = "<leader>wq";
      mode = "n";
      silent = true;
      desc = "Close window";
    }
    {
      action = ":ToggleTerm<cr>";
      key = "<leader>ot";
      mode = "n";
      silent = true;
      desc = "Open terminal";
    }
    {
      action = "<C-\\><C-n>";
      key = "<C-d>";
      mode = "t";
      silent = true;
      desc = "Exit term mode";
    }
    {
      action = ":lua require('conform').format()<cr>";
      key = "<Leader>of";
      mode = "n";
      silent = true;
      desc = "Format";
    }
  ];
}
