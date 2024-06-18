{ pkgs, ... }:

{
  config = {
    # Packages to install:
    environment.systemPackages = [
      (pkgs.callPackage ../pkgs/pjones-avatar.nix { })
    ];

    # System services that need to be running:
    services.udisks2.enable = true;

    # Fonts:
    fonts = {
      fontconfig.enable = true;
      fontDir.enable = true;
      enableGhostscriptFonts = true;
      packages = with pkgs; [
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
