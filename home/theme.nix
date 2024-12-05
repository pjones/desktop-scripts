{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.pjones.desktop-scripts.enable {
    # For Gnome settings:
    dconf.enable = true;

    # For Qt apps:
    qt = {
      enable = true;
      platformTheme.name = "gtk3";
    };

    gtk = {
      enable = true;

      theme = {
        package = pkgs.gnome-themes-extra;
        name = "Adwaita-dark";
      };

      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };

      cursorTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
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

    home.packages = [
      pkgs.glib.bin # For gsettings
    ];

    xdg.desktopEntries = {
      dark-theme = {
        name = "Prefer a Dark Theme";
        icon = "emblem-system";
        terminal = false;
        categories = [ "System" ];
        exec = "desktop-theme-dark";
      };

      light-theme = {
        name = "Prefer a Light Theme";
        icon = "emblem-system";
        terminal = false;
        categories = [ "System" ];
        exec = "desktop-theme-light";
      };
    };
  };
}
