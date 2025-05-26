[
  {
    action = ":lua MiniFiles.open()<cr>";
    key = "<leader>fo";
    options = {
      silent = true;
      noremap = true;
      desc = "Open Yazi";
    };
  }

  {
    action = ":Neogit <cr>";
    key = "<leader>gg";
    options = {
      silent = true;
      noremap = true;
      desc = "Open Git";
    };
  }

  {
    action = ":UndotreeToogle<cr>";
    key = "<leader>tu";
    options = {
      silent = true;
      noremap = true;
      desc = "Toogle Undotree";
    };
  }

  {
    action = ":bd<cr>";
    key = "<leader>bd";
    options = {
      silent = true;
      noremap = true;
      desc = "Delete buffer";
    };
  }
]
