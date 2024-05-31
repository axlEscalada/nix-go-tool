{pkgs ? import <nixpkgs> {}}: (pkgs.mkShell {
  buildInputs = [(import ./default.nix pkgs).goTool];
})
