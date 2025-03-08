{
  lib,
  self,
  pkgs,
  runCommand,
  nixosOptionsDoc,
}: let
  eval = lib.evalModules {
    specialArgs = {inherit self pkgs;};

    modules = [
      (lib.nixosSystem {
        inherit (pkgs) system;
        modules = [
          ../modules/default.nix
        ];
      })
    ];
  };

  optionsDoc = nixosOptionsDoc {
    inherit (eval) options;
  };
in
  runCommand "options-doc.md" {} ''
    cat ${optionsDoc.optionsCommonMark} >> $out
  ''
