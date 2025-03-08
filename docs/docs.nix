/*
{ pkgs
, ...
}:

let
  inherit (pkgs) stdenv mkdocs python310Packages;
  options-doc = pkgs.callPackage ./options-doc.nix {};
in stdenv.mkDerivation {
  src = ./.;
  name = "docs";

  buildInput = [ options-doc ];

  nativeBuildInputs = [
      mkdocs
      python310Packages.mkdocs-material
      python310Packages.pygments
    ];

    buildPhase = ''
      ln -s ${options-doc} "./docs/nixos-options.md"
      mkdocs build
    '';

    installPhase = ''
      mv site $out
    '';
  }
*/
{
  writeShellScriptBin,
  pkgs,
  self,
  ...
}: let
  options-doc = pkgs.callPackage ./options-doc.nix {inherit self;};
in
  writeShellScriptBin "gen-options-doc" ''
    echo "Generating NixOS module options documentation"
    cat ${options-doc} > OPTIONS.md
  ''
