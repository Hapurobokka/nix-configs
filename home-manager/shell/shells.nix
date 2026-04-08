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
      enable = false;
      extraConfig = /* nu */ ''
        use std/util "path add"
        $env.config.buffer_editor = "nvim"
        $env.config.show_banner = false
        $env.__zoxide_hooked = true
        $env.config.edit_mode = "vi"

        path add "~/.emacs.d/bin"
        path add "~/.bin"
      '';
    };
  };
}
