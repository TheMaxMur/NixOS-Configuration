{self, ...}: {
  home.file.".config/Code/User/keybindings.json".source = "${self}/home/modules/vscode/keybindings/keybindings.json";
}
