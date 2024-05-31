{pkgs ? import <nixpkgs> {}}: let
  goTool = pkgs.buildGoModule {
    pname = "go-tool";
    version = "1.0.0"; # Update this with your tool's version
    src = ./.; # Use the current directory as the source

    vendorSha256 = null;

    subPackages = ["."]; # Adjust if the Go module is in a subdirectory
  };
in
  pkgs.mkShell {
    buildInputs = [goTool];

    shellHook = ''
      echo "Run your tool with: my-go-tool <arg1>"
    '';
  }
