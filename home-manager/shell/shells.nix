{ ... }:
{
  programs = {
    nushell = {
      loadSessionVariables = true;
      enable = true;
      extraConfig = /* nu */ ''
        use std/util "path add"
        $env.config.buffer_editor = "nvim"
        $env.config.show_banner = false
        $env.__zoxide_hooked = true
        $env.config.edit_mode = "vi"

        path add "~/.emacs.d/bin"
        path add "~/.bin"
        path add "~/.local/bin/"
        path add "~/.cargo/bin/"
        path add "~/.local/share/nvim/mason/staging/nil/bin"
        path add "~/.config/emacs/bin"
        path add "~/.cache/npm/global/bin"

        source /home/hapu/nix-configs/home-manager/nushell/completions-jj.nu
        source /home/hapu/nix-configs/home-manager/nushell/nb-completions.nu
        $env.LD_LIBRARY_PATH = $"/nix/store/5m91jqg1526jzsahrgmd37k4ml3nc5l4-libx11-1.8.13/lib/:($env.LD_LIBRARY_PATH? | default "")"
      '';
    };
  };
}
