{ config, lib, pkgs, ... }:

{
  options.pjones.desktop-scripts = {
    enable = lib.mkEnableOption "Generic graphical settings";
  };

  config = lib.mkIf config.pjones.desktop-scripts.enable {
    # Packages to install:
    environment.systemPackages = [
      (pkgs.callPackage ../pkgs/pjones-avatar.nix { })
      pkgs.adwaita-qt # A style to bend Qt applications to look like they belong into GNOME Shell
      pkgs.adwaita-qt6 # A style to bend Qt applications to look like they belong into GNOME Shell
      pkgs.gnome.adwaita-icon-theme # Adwaita icon them
      pkgs.gnome.gnome-themes-extra # Dark theme
    ];

    # System services that need to be running:
    services.udisks2.enable = true;

    # For setting GTK themes:
    programs.dconf.enable = true;
    services.dbus.packages = [ pkgs.dconf ];

    # Fonts:
    fonts = {
      fontconfig.enable = true;
      fontDir.enable = true;
      enableGhostscriptFonts = true;
      packages = with pkgs; [
        (pkgs.callPackage ../pkgs/nerd-hyperlegible.nix { })
        atkinson-hyperlegible
        dejavu_fonts
        hermit
        ibm-plex
        nerdfonts
        overpass
        tt2020
        ubuntu_font_family
      ];
    };
  };
}
