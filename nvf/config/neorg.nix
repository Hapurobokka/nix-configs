{ lib, ... }:
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

    autocmds = [
      {
        desc = "Follow Neorg links with Enter";
        event = [ "FileType" ];
        pattern = [ "norg" ];
        callback = lib.generators.mkLuaInline /* lua */ ''
          function()
            vim.keymap.set("n", "<cr>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true })
          end
        '';
      }
    ];
  };
}
