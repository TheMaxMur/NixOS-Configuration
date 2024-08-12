{ pkgs
, ...
}:

{
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    # "13xforever".language-x86-64-assembly
    arcticicestudio.nord-visual-studio-code
    naumovs.theme-oceanicnext
    vlanguage.vscode-vlang
    tal7aouy.icons
    hashicorp.hcl
    redhat.ansible
    vscjava.vscode-java-pack
    visualstudioexptteam.vscodeintellicode
    visualstudioexptteam.intellicode-api-usage-examples
    ms-vscode.cpptools-extension-pack
    stylelint.vscode-stylelint
    reloadedextensions.reloaded-cpp
    mathiasfrohlich.kotlin
    hediet.vscode-drawio
    hars.cppsnippets
    firsttris.vscode-jest-runner
    equinusocio.vsc-material-theme-icons
    cweijan.dbclient-jdbc
    dart-code.dart-code
    vscjava.vscode-java-debug
    ms-vscode-remote.remote-containers
    ms-azuretools.vscode-docker
    dbaeumer.vscode-eslint
    dart-code.flutter
    gitlab.gitlab-workflow
    eamodio.gitlens
    golang.go
    hashicorp.terraform
    ms-python.isort
    wholroyd.jinja
    ms-toolsai.jupyter
    ms-toolsai.vscode-jupyter-cell-tags
    ms-toolsai.jupyter-keymap
    ms-toolsai.jupyter-renderers
    ms-toolsai.vscode-jupyter-slideshow
    ms-kubernetes-tools.vscode-kubernetes-tools
    redhat.java
    ritwickdey.liveserver
    pkief.material-icon-theme
    equinusocio.vsc-material-theme
    vscjava.vscode-maven
    bbenoist.nix
    esbenp.prettier-vscode
    vscjava.vscode-java-dependency
    ms-python.vscode-pylance
    ms-python.python
    vscjava.vscode-java-test
    gruntfuggly.todo-tree
    xadillax.viml
    redhat.vscode-yaml
  ];
}

