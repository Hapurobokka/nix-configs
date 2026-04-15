{ pkgs, ... }: {
  vim = {
    lsp = {
      enable = true;
      inlayHints.enable = false;
      lightbulb.enable = true;
      lspconfig.enable = false;
    };
    formatter.conform-nvim = {
      enable = true;
      setupOpts.formatters_by_ft = {
        python = [ "ruff" ];
        cpp = [ "clang-format" ];
      };
    };
    treesitter = {
      grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      highlight.enable = true;
    };
    languages = {
      enableFormat = true;
      go = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
      nix = {
        enable = true;
        extraDiagnostics.enable = true;
        format.enable = true;
        treesitter.enable = true;
        lsp = {
          enable = true;
          servers = [ "nixd" ];
        };
      };
      nim = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
      rust = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
      clang = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
      scala = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
      python = {
        enable = true;
        treesitter.enable = true;
        format.enable = true;
        lsp = {
          enable = true;
          servers = [
            "ty"
            "ruff"
          ];
        };
      };
      typst = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
    };
  };
}
