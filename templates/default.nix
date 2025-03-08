{self, ...}: {
  devshell = {
    description = "Flake devshell template";
    path = "${self}/templates/devshell";
  };

  module = {
    description = "NixOS module template";
    path = "${self}/templates/module";
  };

  overlay = {
    description = "NixOS overlay template";
    path = "${self}/templates/overlay";
  };
}
