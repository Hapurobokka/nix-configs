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
      action = ":Trouble<cr>";
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
      key = "<leader>fs";
      mode = "n";
      silent = true;
      desc = "Show lsp symbols";
    }
    {
      action = ":lua MiniFiles.open()<cr>";
      key = "<leader>oe";
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
      action = ":ToggleTerm<cr>";
      key = "<leader>ot";
      mode = "n";
      silent = true;
      desc = "Open terminal";
    }
    {
      action = "<C-\\><C-n>";
      key = "<C-p>";
      mode = "t";
      silent = true;
      desc = "Exit term mode";
    }
    {
      action = ":lua vim.lsp.buf.definition()<cr>";
      key = "gd";
      mode = "n";
      silent = true;
      desc = "Go to definition";
    }
    {
      action = ":lua vim.lsp.buf.declaration()<cr>";
      key = "gD";
      mode = "n";
      silent = true;
      desc = "Go to declaration";
    }
  ];
}
