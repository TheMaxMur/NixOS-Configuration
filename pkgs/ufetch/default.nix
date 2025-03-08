{
  lib,
  stdenv,
  fetchFromGitLab,
  makeWrapper,
  bash,
}:
stdenv.mkDerivation rec {
  pname = "ufetch";
  version = "0.3";

  src = fetchFromGitLab {
    owner = "jschx";
    repo = "ufetch";
    rev = "v${version}";
    sha256 = "0sv17zmvhp0vfdscs8yras7am10ah7rpfyfia608sx74k845bfyl";
  };

  strictDeps = true;
  nativeBuildInputs = [makeWrapper];
  buildInputs = [bash];
  installPhase = ''
    mkdir -p $out/bin
    cp -r ufetch-nixos $out/bin
    wrapProgram $out/bin/ufetch-nixos --prefix PATH ":" $out/bin
  '';

  meta = with lib; {
    description = "Tiny system info for Unix-like operating systems";
    license = licenses.mit;
    homepage = "https://gitlab.com/jschx/ufetch";
    # maintainers = with maintainers; [ haslersn ];
    # mainProgram = "any-nix-shell";
  };
}
