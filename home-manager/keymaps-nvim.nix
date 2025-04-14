[
  {
    action = ":lua MiniFiles.open()<cr>";
    key = "<leader>fo";
    options = {
      silent = true;
      noremap = true;
      desc = "Open Oil";
    };
  }

  {
    action = ":OverseerOpen<cr>";
    key = "<leader>co";
    options = {
      silent = true;
      noremap = true;
      desc = "Open Overseer";
    };
  }

  {
    action = ":OverseerRun<cr>";
    key = "<leader>cc";
    options = {
      silent = true;
      noremap = true;
      desc = "Run task";
    };
  }

  {
    action = ":OverseerInfo<cr>";
    key = "<leader>ci";
    options = {
      silent = true;
      noremap = true;
      desc = "Overseer status";
    };
  }

  {
    action = ":OverseerRunCmd<cr>";
    key = "<leader>cr";
    options = {
      silent = true;
      noremap = true;
      desc = "Run shell command";
    };
  }
]
