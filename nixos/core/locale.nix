{ pkgs, ... }: {
  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_MX.UTF-8";
  console.keyMap = "la-latin1";
  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];
  };
}
