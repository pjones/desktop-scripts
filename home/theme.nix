{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.pjones.desktop-scripts.enable {
    # For Gnome settings:
    dconf.enable = true;

    gtk = {
      enable = true;

      theme = {
        package = pkgs.pkgs.gnome.gnome-themes-extra;
        name = "Adwaita-dark";
      };

      iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };

      cursorTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
        size = 24;
      };

      font = {
        package = pkgs.atkinson-hyperlegible;
        name = "Atkinson Hyperlegible Regular 12";
      };

      gtk2.extraConfig = ''
        gtk-key-theme-name="Emacs"
      '';

      gtk3.extraConfig = {
        gtk-key-theme-name = "Emacs";
      };
    };
  };
}
