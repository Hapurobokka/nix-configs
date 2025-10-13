{ pkgs, lib, ... }:

{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "catppuccin";
          style = "frappe";
        };

        options = {
          number = true;
          relativenumber = true;
          cursorline = true;

          shiftwidth = 4;
          tabstop = 4;
          smartindent = true;
          expandtab = true;
          softtabstop = 4;

          ignorecase = true;
          smartcase = true;

          signcolumn = "yes";
          splitbelow = true;
          splitright = true;
          termguicolors = true;
          timeoutlen = 400;
          undofile = true;
          conceallevel = 2;

          wrap = true;
          linebreak = true;
          foldlevel = 1;
        };

        autocmds = [
          {
            desc = "Changes the indent size to 2 in certain files";
            event = [ "FileType" ];
            callback = lib.generators.mkLuaInline /*lua*/ ''
              function()
                  vim.bo.tabstop = 2
                  vim.bo.shiftwidth = 2
                  vim.bo.expandtab = true
              end
    				'';
    				pattern = [
    					"javascript"
              "css"
              "haskell"
              "html"
              "javascriptreact"
              "lua"
              "nim"
              "nix"
              "svelte"
              "typescript"
              "typescriptreact" 
              "xml"
    				];
          }
        ];
        
        lsp = {
          enable = true;
        };

        extraPlugins = with pkgs.vimPlugins; {
          plenary = {
            package = plenary-nvim;
          };      
        };

        mini = {
          statusline.enable = true;
          pairs.enable = true;
          ai.enable = true;
          bracketed.enable = true;
          jump.enable = true;
          notify.enable = true;
          operators.enable = true;
          starter.enable = true;
          icons.enable = true;
        };
        fzf-lua.enable = true;
        autocomplete.blink-cmp.enable = true;
        binds.whichKey = {
          enable = true;
        };
        git.gitsigns.enable = true;
        utility = {
          oil-nvim.enable = true;
          motion.flash-nvim.enable = true;
        }; 

        notes.obsidian = {
          enable = true;
          setupOpts = {
            workspaces = [
              {
                name = "vault";
                path = "~/Documentos/vault";
              }
            ];
            daily_notes = {
              folder = "fleeting/";
              date = "%d-%m-%Y";
              default_tags = [ "fleeting" ];
            };
          };
        };

        languages = {
          nix = {
            enable = true;
            extraDiagnostics.enable = true;
            format.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          rust = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          markdown.extensions.markview-nvim.enable = true;
        };

        treesitter = {
          grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
        };

        keymaps = [
          {
            action = ":FzfLua files<cr>";
            key = "<leader>ff";
            mode = "n";
            silent = true;
            desc = "Open files";
          }
          {
            action = ":FzfLua buffers<cr>";
            key = "<leader>bb";
            mode = "n";
            silent = true;
            desc = "Open buffers";
          }
          {
            action = ":FzfLua live_grep<cr>";
            key = "<leader>fg";
            mode = "n";
            silent = true;
            desc = "Open buffers";
          }
          {
            action = ":FzfLua diagnostics_document<cr>";
            key = "<leader>fd";
            mode = "n";
            silent = true;
            desc = "Open diagnostics";
          }
          {
            action = ":FzfLua oldfiles<cr>";
            key = "<leader>fr";
            mode = "n";
            silent = true;
            desc = "Open recent files";
          }
          {
            action = ":FzfLua lsp_document_symbols<cr>";
            key = "<leader>fs";
            mode = "n";
            silent = true;
            desc = "Open Oil";
          }
          {
            action = ":Oil<cr>";
            key = "<leader>oo";
            mode = "n";
            silent = true;
            desc = "Open Oil";
          }
          {
            action = ":bdelete<cr>";
            key = "<leader>bd";
            mode = "n";
            silent = true;
            desc = "Delete buffer";
          }
        ];
      };
    };
  };
}
