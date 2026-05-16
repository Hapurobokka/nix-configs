{ ... }:
{
  vim.notes.neorg = {
    enable = true;
    treesitter.enable = true;
    setupOpts.load = {
      "core.defaults".enable = true;
      "core.concealer" = { };
      "core.dirman".config = {
        workspaces.notes = "~/notes";
        index = "index.norg";
        default_workspace = "main";
      };
    };
  };
}
