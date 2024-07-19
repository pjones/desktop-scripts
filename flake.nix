{
  description = "Peter's desktop configuration and scripts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs, ... }:
    let
      # List of supported systems:
      supportedSystems = nixpkgs.lib.platforms.unix;

      # Function to generate a set based on supported systems:
      forAllSystems = f:
        nixpkgs.lib.genAttrs supportedSystems (system: f system);

      # Attribute set of nixpkgs for each system:
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      packages = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in {
          default = self.packages.${system}.desktop-scripts;
          desktop-scripts = import ./. { inherit pkgs; };
          nerd-hyperlegible = pkgs.callPackage pkgs/nerd-hyperlegible.nix { };
        });

      overlays = {
        desktop-scripts = final: prev: {
          pjones = (prev.pjones or { }) //
            { desktop-scripts = self.packages.${prev.system}.desktop-scripts; };
        };
      };

      nixosModules.default = import ./nixos;
      homeManagerModules.default = import ./home;
    };
}
