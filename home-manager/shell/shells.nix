{ pkgs, ... }:
{
  programs = {
    fish = {
      enable = false;
      shellInit = /* fish */ ''
        fish_add_path ~/.local/bin
        fish_vi_key_bindings
        fish_add_path ~/.cargo/bin
        fish_add_path ~/.bin
        fish_add_path ~/.nimble/bin
        fish_add_path ~/.config/emacs/bin
        alias ls 'eza --icons'
      '';
    };
    nushell = {
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
        path add "~/.local/share/nvim/mason/staging/nil/bin"
        path add "~/.config/emacs/bin"

        source /home/hapu/nix-configs/home-manager/nushell/completions-jj.nu
        source /home/hapu/nix-configs/home-manager/nushell/nb-completions.nu
        $env.LD_LIBRARY_PATH = $"/nix/store/5m91jqg1526jzsahrgmd37k4ml3nc5l4-libx11-1.8.13/lib/:($env.LD_LIBRARY_PATH? | default "")"
      '';
    };
    carapace.enable = true;
    carapace.enableNushellIntegration = true;
  };
}
