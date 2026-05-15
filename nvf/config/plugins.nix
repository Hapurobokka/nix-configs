{ pkgs, lib, ... }:
let
  lspHover = pkgs.vimUtils.buildVimPlugin {
    name = "lsp-hover";
    src = pkgs.writeTextFile {
      name = "lsp-hover-src";
      text = builtins.readFile ../lua/lsp_hover.lua;
      destination = "/lua/lsp_hover.lua";
    };
  };
in
{
  vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "frappe";
    };
    ui.noice = {
      enable = true;
      setupOpts = {
        routes = [
          {
            filter = {
              event = "msg_show";
              kind = "";
              find = "written";
            };
            opts = {
              skip = true;
            };
          }
          {
            filter = {
              event = "msg_show";
              kind = "";
              find = "lines --";
            };
            opts = {
              skip = true;
            };
          }
          {
            filter = {
              event = "msg_show";
              kind = "";
              find = "L,";
            };
            opts = {
              skip = true;
            };
          }
          {
            filter = {
              event = "msg_show";
              kind = "";
              find = "^\".*\"$";
            };
            opts = {
              skip = true;
            };
          }
        ];
      };
    };
    git.gitsigns.enable = true;
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
        sources.providers.lsp.transform_items = lib.generators.mkLuaInline /* lua */ ''
          function(_, items)
            local function sanitize(t)
              for k, v in pairs(t) do
                if type(v) == "userdata" then
                  t[k] = nil
                elseif type(v) == "table" then
                  sanitize(v)
                end
              end
            end
            for _, item in ipairs(items) do
              sanitize(item)
            end
            return items
          end
        '';
      };
    };
    notes.obsidian = {
      enable = false;
      setupOpts = {
        workspaces = [
          {
            name = "vault";
            path = "~/Documentos/vault";
          }
        ];
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
    lazy.plugins = with pkgs.vimPlugins; {
      "jj.nvim" = {
        package = jj-nvim;
        setupModule = "jj";
        keys = [
          {
            action = ":J log<cr>";
            key = "<leader>ojj";
            mode = "n";
            silent = true;
            desc = "Open Jujutsu Log";
          }
          {
            action = ":J status<cr>";
            key = "<leader>ojs";
            mode = "n";
            silent = true;
            desc = "Open Jujutsu Log";
          }
        ];
      };
      undotree = {
        package = undotree;
        keys = [
          {
            action = ":UndotreeToggle<cr>";
            key = "<leader>tu";
            desc = "Toggle Undotree";
            mode = "n";
            silent = true;
          }
        ];
      };
      vim-tmux-navigator = {
        package = vim-tmux-navigator;
        cmd = [
          "TmuxNavigateLeft"
          "TmuxNavigateDown"
          "TmuxNavigateUp"
          "TmuxNavigateRight"
          "TmuxNavigatePrevious"
          "TmuxNavigatorProcessList"
        ];
        keys = [
          {
            key = "<c-h>";
            action = "<cmd><C-U>TmuxNavigateLeft<cr>";
            desc = "Tmux Left";
            mode = "n";
          }
          {
            key = "<c-j>";
            action = "<cmd><C-U>TmuxNavigateDown<cr>";
            desc = "Tmux Down";
            mode = "n";
          }
          {
            key = "<c-k>";
            action = "<cmd><C-U>TmuxNavigateUp<cr>";
            desc = "Tmux Up";
            mode = "n";
          }
          {
            key = "<c-l>";
            action = "<cmd><C-U>TmuxNavigateRight<cr>";
            desc = "Tmux Right";
            mode = "n";
          }
        ];
      };
    };
    extraPlugins = with pkgs.vimPlugins; {
      plenary = {
        package = plenary-nvim;
      };
      markview = {
        package = markview-nvim;
        setup = /* lua */ ''
          require('markview').setup({
            preview = {
              ignore_buftypes = {},
            },
          })
        '';
      };
      lsp-hover = {
        package = lspHover;
        setup = /* lua */ "require('lsp_hover').setup()";
      };
      typst-preview = {
        package = typst-preview-nvim;
        setup = /* lua */ "require 'typst-preview'.setup {}";
      };
      # kanagawa = {
      #   package = kanagawa-nvim;
      #   setup = /* lua */ ''
      #     require('kanagawa').setup({ transparent = true; })
      #     vim.cmd 'colorscheme kanagawa'
      #   '';
      # };
    };
  };
}
