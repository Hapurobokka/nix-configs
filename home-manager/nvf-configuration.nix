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

        mini = {
          statusline.enable = true;
          pairs.enable = true;
        };
        fzf-lua.enable = true;
        autocomplete.blink-cmp.enable = true;
        binds.whichKey = {
          enable = true;
        };
        git.gitsigns.enable = true;

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
        ];
      };
    };
  };
}
