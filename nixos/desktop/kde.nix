{ pkgs, config, ... }:
{
  services = {
    displayManager.ly = {
      enable = true;
    };
  };

  # Add KDE-specific environment packages
  environment.systemPackages = with pkgs.kdePackages; [
    kdenlive          # Video editor (optional, feel free to remove)
    gwenview          # Image viewer
    ark               # Archive manager
    ksystemlog        # System log viewer
    partitionmanager  # Disk partition manager
  ];
}
