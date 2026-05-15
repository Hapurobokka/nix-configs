{ pkgs, lib, ... }:
{
  vim = {
    lsp = {
      enable = true;
      inlayHints.enable = false;
      lightbulb.enable = true;
      lspconfig.enable = false;
      trouble.enable = true;
      lspkind.enable = true;
    };
    formatter.conform-nvim = {
      enable = true;
      setupOpts.formatters_by_ft = {
        python = [ "ruff" ];
        cpp = [ "clang-format" ];
        rust = [ "rustfmt" ];
      };
    };
    extraPackages = [ pkgs.nimlangserver ];

    autocmds = [
      {
        desc = "Start nimlangserver for Nim files";
        event = [ "FileType" ];
        pattern = [ "nim" ];
        callback = lib.generators.mkLuaInline /* lua */ ''
          function(args)
            local function sanitize(t)
              for k, v in pairs(t) do
                if type(v) == "userdata" then
                  t[k] = nil
                elseif type(v) == "table" then
                  sanitize(v)
                end
              end
            end
            vim.lsp.start({
              name = "nimlangserver",
              cmd = { "nimlangserver" },
              root_dir = vim.fs.root(args.buf, { "*.nimble", ".git" }),
              handlers = {
                ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
                  if result and result.diagnostics then
                    for _, diag in ipairs(result.diagnostics) do
                      sanitize(diag)
                    end
                  end
                  vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
                end,
                ["textDocument/rename"] = function(err, result, ctx, config)
                  if result then sanitize(result) end
                  vim.lsp.handlers["textDocument/rename"](err, result, ctx, config)
                end,
              },
            })
          end
        '';
      }
    ];

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
        lsp.enable = false;
        treesitter.enable = true;
      };
      rust = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
        format.enable = true;
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
