{ config, pkgs, ... }:

let
  avatar = pkgs.callPackage ../pkgs/pjones-avatar.nix { };
in
{
  config = {
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
