{ lib, ... }: {
  vim.mini = {
    ai.enable = true;
    animate.enable = true;
    bracketed.enable = true;
    extra.enable = true;
    files.enable = true;
    bufremove.enable = true;
    icons.enable = true;
    jump.enable = true;
    jump2d.enable = false;
    map.enable = true;
    operators.enable = true;
    pairs.enable = true;
    pick.enable = true;
    starter.enable = true;
    statusline.enable = true;
    surround.enable = true;
    tabline.enable = true;
    clue = {
      enable = true;
      setupOpts = {
        triggers = [
          { mode = "n"; keys = "<Leader>"; }
          { mode = "x"; keys = "<Leader>"; }
          { mode = "i"; keys = "<C-x>"; }
          { mode = "n"; keys = "g"; }
          { mode = "x"; keys = "g"; }
          { mode = "n"; keys = ","; }
          { mode = "x"; keys = ","; }
          { mode = "n"; keys = "\""; }
          { mode = "n"; keys = "\`"; }
          { mode = "x"; keys = "\""; }
          { mode = "x"; keys = "`"; }
          { mode = "n"; keys = "s"; }
          { mode = "x"; keys = "s"; }
          { mode = "i"; keys = "<C-r>"; }
          { mode = "c"; keys = "<C-r>"; }
          { mode = "n"; keys = "<C-w>"; }
          { mode = "n"; keys = "z"; }
          { mode = "x"; keys = "z"; }
        ];
        clues = lib.generators.mkLuaInline /* lua */ ''
          {
            require('mini.clue').gen_clues.builtin_completion(),
            require('mini.clue').gen_clues.g(),
            require('mini.clue').gen_clues.marks(),
            require('mini.clue').gen_clues.registers(),
            require('mini.clue').gen_clues.windows(),
            require('mini.clue').gen_clues.z(),
          }
        '';
      };
    };
  };
}
