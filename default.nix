{ pkgs ? import <nixpkgs> { }
}:
let
  lib = pkgs.lib;
  stdenv = pkgs.stdenvNoCC;

  deps = with pkgs; [
    coreutils
    findutils
    gnugrep
    openssh
    procps
  ];

  path = lib.makeBinPath deps;
in
stdenv.mkDerivation {
  name = "desktop-scripts";
  src = ./.;

  dontBuild = true;
  buildInputs = deps ++ [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p "$out/bin" "$out/wrapped"

    for file in bin/*; do
      name=$(basename "$file")
      install -m 0555 "$file" "$out/wrapped"

      makeWrapper "$out/wrapped/$name" "$out/bin/$name" \
        --prefix PATH : "${path}"
    done
  '';
}
