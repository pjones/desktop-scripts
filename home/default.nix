{ config, lib, pkgs, ... }:

let
  avatar = pkgs.callPackage ../pkgs/pjones-avatar.nix { };
in
{
  options.pjones.desktop-scripts = {
    enable = lib.mkEnableOption "Generic graphical settings";
  };

  config = lib.mkIf config.pjones.desktop-scripts.enable {
    # Additional packages to install:
    home.packages = with pkgs; [
      networkmanagerapplet # NetworkManager control applet for GNOME
    ];

    # This uses `xsession` but it's needed for Wayland too:
    xsession.preferStatusNotifierItems = true;

    # Tray icon for network connections:
    services.network-manager-applet.enable = true;

    # Tray icon for disks:
    services.udiskie = {
      enable = true;
      automount = false;
    };

    # Set XDG user directories:
    xdg.userDirs = {
      enable = true;
      createDirectories = false;

      desktop = "$HOME/desktop";
      documents = "$HOME/documents";
      download = "$HOME/download";
      music = "$HOME/documents/music";
      pictures = "$HOME/documents/pictures";
      publicShare = "$HOME/public";
      templates = "$HOME/documents/templates";
      videos = "$HOME/documents/videos";
    };

    # Application menu items:
    xdg.desktopEntries = {
      lock-screen = {
        name = "Lock Screen";
        exec = "loginctl lock-session";
        icon = "emblem-system";
        terminal = false;
        categories = [ "System" ];
      };

      sleep-system = {
        name = "Sleep";
        exec = "systemctl suspend-then-hibernate";
        icon = "emblem-system";
        terminal = false;
        categories = [ "System" ];
      };
    };

    # For apps that want a user picture like GDM:
    home.file.".face".source = "${avatar}/share/faces/pjones.jpg";
  };
}
