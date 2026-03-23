{ pkgs, ... }:
{
  programs.nvf.settings.vim = {
    theme = {
      enable = false;
      name = "catppuccin";
      style = "frappe";
    };
    ui.noice.enable = true;
    git.gitsigns.enable = true;
    visuals.fidget-nvim.enable = true;
    presence.neocord.enable = true;
    terminal.toggleterm.enable = true;
    binds.hardtime-nvim.enable = true;
    fzf-lua.enable = false;
    utility = {
      oil-nvim.enable = false;
      motion = {
        precognition.enable = false;
        flash-nvim = {
          enable = true;
          mappings = {
            jump = "S";
            treesitter = null;
          };
        };
      };
    };
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      setupOpts = {
        keymap.preset = "default";
        cmdline.keymap.preset = "default";
      };
    };
    notes.neorg = {
      enable = true;
      treesitter.enable = true;
      setupOpts.load = {
        "core.defaults".enable = true;
        "core.concealer" = { };
        "core.dirman".config = {
          workspaces.main = "~/neorg";
          index = "index.norg";
          default_workspace = "main";
        };
      };
    };
    lazy.plugins.jj-nvim = {
      package = "jj-nvim";
      setupModule = "jj";
      keys = [
        {
          action = ":J log<cr>";
          key = "<Leader>ojj";
          mode = "n";
          silent = true;
          desc = "Open Jujutsu Log";
        }
        {
          action = ":J status<cr>";
          key = "<Leader>ojs";
          mode = "n";
          silent = true;
          desc = "Open Jujutsu Log";
        }
      ];
    };
    extraPlugins = with pkgs.vimPlugins; {
      plenary = {
        package = plenary-nvim;
      };
      markview = {
        package = markview-nvim;
      };
      table-mode = {
        package = vim-table-mode;
      };
      undotree = {
        package = undotree;
      };
      typst-preview = {
        package = typst-preview-nvim;
        setup = /* lua */ "require 'typst-preview'.setup {}";
      };
      kanagawa = {
        package = kanagawa-nvim;
        setup = /* lua */ ''
          require('kanagawa').setup({ transparent = true; })
          vim.cmd 'colorscheme kanagawa'
        '';
      };
    };
  };
}
