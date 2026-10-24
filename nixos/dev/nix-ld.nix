{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      vulkan-loader
      wayland
      libxkbcommon
      libdecor
      pipewire
      libpulseaudio
      fuse3
      icu
      nss
      openssl
      curl
      expat
    ];
  };
}
