{
  description = "A flake for my Go tool";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f: builtins.foldl' (acc: system: acc // {inherit (f system) ${system};}) {} systems;
  in {
    packages = forAllSystems (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        default = pkgs.buildGoModule {
          pname = "go-tool";
          version = "1.0.0";
          src = self;
          vendorSha256 = null;
          subPackages = ["."];
        };
      }
    );

    apps = forAllSystems (
      system: let
        pkg = self.packages.${system}.default;
      in {
        default = {
          type = "app";
          program = "${pkg}/bin/my-go-tool";
        };
      }
    );
  };
}
