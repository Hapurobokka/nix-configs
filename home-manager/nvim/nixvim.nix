{ pkgs, inputs, ... }:
{
  programs.nixvim = {
    enable = true;

    globals = {
      mapleader = " ";
    };

    opts = {
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

    clipboard = {
      register = "unnamedplus";
    };

		autoCmd = [
			{
        desc = "Changes the indent size to 2 in certain files";
				event = "FileType";
				callback = { __raw = /*lua*/ ''
            function()
              vim.bo.tabstop = 2
              vim.bo.shiftwidth = 2
              vim.bo.expandtab = true
              end
  				'';
        };
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
      {
        desc = "Highliht selection in yank";
        pattern = "*";
        event = "TextYankPost";
        callback = { __raw = /*lua*/ ''
            function()
              vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
            end
          '';
        };
      }
		];


    extraPlugins = with pkgs.vimPlugins; [
      vim-signify
      goyo-vim
      limelight-vim
      snacks-nvim
      lazygit-nvim
    ];

    extraConfigLua = /*lua*/ ''
      vim.cmd("set spelllang=es")

      local spell_dir = vim.fn.stdpath("data") .. "/spell"
      vim.opt.spellfile = spell_dir .. "/es.utf-8.add"

      require("snacks").setup({
        quickfile = { enabled = true },
        bigfile = { enabled = true },
      })
    '';

    plugins = import ./plugins-nvim.nix;

    keymaps = import ./keymaps-nvim.nix;

    colorschemes.catppuccin = {
      enable = false;
      settings = {
        flavour = "macchiato";
      };
    };

    colorschemes.kanagawa = {
      enable = true;
    };
  };
}
