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
            local dict_path = vim.fn.stdpath("data") .. "/ltex-dictionary.txt"

            local function load_dict()
              local words = {}
              local f = io.open(dict_path, "r")
              if f then
                for line in f:lines() do
                  if line ~= "" then table.insert(words, line) end
                end
                f:close()
              end
              return words
            end

            local function save_word(word)
              local f = io.open(dict_path, "a")
              if f then f:write(word .. "\n"); f:close() end
            end

            vim.lsp.commands["_ltex.addToDictionary"] = function(command, ctx)
              local words_by_lang = command.arguments and command.arguments[1] and command.arguments[1].words
              if words_by_lang then
                for _, lang_words in pairs(words_by_lang) do
                  for _, word in ipairs(lang_words) do
                    save_word(word)
                  end
                end
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                if client then
                  client.config.settings.ltex.dictionary = { es = load_dict() }
                  client.notify("workspace/didChangeConfiguration", {
                    settings = client.config.settings,
                  })
                end
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
                  dictionary = { es = load_dict() },
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
