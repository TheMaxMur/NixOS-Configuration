{ homeModules
, ...
}:

{
  home.file.".config/Code/User/keybindings.json".source = "${homeModules}/vscode/keybindings/keybindings.json";
}

