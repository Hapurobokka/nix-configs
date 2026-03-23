{ lib, ... }:
{
  vim = {
    options = {
      autoindent = true;
      cursorline = true;
      expandtab = true;
      foldlevelstart = 99;
      formatoptions = "rqnl1j";
      ignorecase = true;
      incsearch = true;
      infercase = true;
      linebreak = true;
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      shortmess = "CFOSWaco";
      signcolumn = "yes";
      smartcase = true;
      smartindent = true;
      softtabstop = 4;
      splitbelow = true;
      splitkeep = "screen";
      splitright = true;
      switchbuf = "usetab";
      tabstop = 4;
      termguicolors = true;
      timeoutlen = 400;
      undofile = true;
      virtualedit = "block";
      winborder = "single";
      wrap = true;
    };

    clipboard = {
      enable = true;
      registers = "unnamedplus";
    };

    spellcheck = {
      enable = false;
      languages = [ "es" ];
      ignoredFiletypes = [
        "toggleterm"
        "term"
        "scratch"
      ];
    };

    autocmds = [
      {
        desc = "Changes the indent size to 2 in certain files";
        event = [ "FileType" ];
        callback = lib.generators.mkLuaInline /* lua */ ''
          function()
              vim.bo.tabstop = 2
              vim.bo.shiftwidth = 2
              vim.bo.expandtab = true
          end
        '';
        pattern = [
          "css"
          "haskell"
          "html"
          "javascript"
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
  };
}
