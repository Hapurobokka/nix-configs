{ pkgs, lib, ... }:
{
  vim = {
    notes.neorg = {
      enable = true;
      treesitter.enable = true;
      setupOpts.load = {
        "core.defaults".enable = true;
        "core.concealer" = { };
        "core.dirman".config = {
          workspaces.notes = "~/notes";
          index = "index.norg";
          default_workspace = "notes";
        };
      };
    };

    extraPackages = [ pkgs.ltex-ls ];

    autocmds = [
      {
        desc = "Start ltex-ls and enable spell for Neorg files";
        event = [ "FileType" ];
        pattern = [ "norg" ];
        callback = lib.generators.mkLuaInline /* lua */ ''
          function(args)
            local dict_path  = vim.fn.stdpath("data") .. "/ltex-dictionary.txt"
            local rules_path = vim.fn.stdpath("data") .. "/ltex-disabled-rules.txt"
            local fp_path    = vim.fn.stdpath("data") .. "/ltex-false-positives.txt"

            local function load_lines(path)
              local lines = {}
              local f = io.open(path, "r")
              if f then
                for line in f:lines() do
                  if line ~= "" then table.insert(lines, line) end
                end
                f:close()
              end
              return lines
            end

            local function append_line(path, line)
              local f = io.open(path, "a")
              if f then f:write(line .. "\n"); f:close() end
            end

            local function reload_settings(client)
              client.config.settings.ltex.dictionary          = { es = load_lines(dict_path) }
              client.config.settings.ltex.disabledRules       = { es = load_lines(rules_path) }
              client.config.settings.ltex.hiddenFalsePositives = { es = load_lines(fp_path) }
              client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end

            vim.lsp.commands["_ltex.addToDictionary"] = function(command, ctx)
              local by_lang = command.arguments and command.arguments[1] and command.arguments[1].words
              if by_lang then
                for _, words in pairs(by_lang) do
                  for _, word in ipairs(words) do append_line(dict_path, word) end
                end
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                if client then reload_settings(client) end
              end
            end

            vim.lsp.commands["_ltex.disableRules"] = function(command, ctx)
              local by_lang = command.arguments and command.arguments[1] and command.arguments[1].ruleIds
              if by_lang then
                for _, rules in pairs(by_lang) do
                  for _, rule in ipairs(rules) do append_line(rules_path, rule) end
                end
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                if client then reload_settings(client) end
              end
            end

            vim.lsp.commands["_ltex.hideFalsePositives"] = function(command, ctx)
              local by_lang = command.arguments and command.arguments[1] and command.arguments[1].falsePositives
              if by_lang then
                for _, fps in pairs(by_lang) do
                  for _, fp in ipairs(fps) do append_line(fp_path, vim.json.encode(fp)) end
                end
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                if client then reload_settings(client) end
              end
            end

            vim.opt_local.spell = true
            vim.opt_local.spelllang = "es"
            vim.lsp.start({
              name = "ltex-ls",
              cmd = { "ltex-ls" },
              root_dir = vim.fs.root(args.buf, { ".git" }) or vim.fn.getcwd(),
              settings = {
                ltex = {
                  language = "es",
                  dictionary          = { es = load_lines(dict_path) },
                  disabledRules       = { es = load_lines(rules_path) },
                  hiddenFalsePositives = { es = load_lines(fp_path) },
                },
              },
            })
            vim.keymap.set("n", "<cr>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true })
          end
        '';
      }
    ];
  };
}
