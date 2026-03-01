{
  description = "codex-acp";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        commonArgs = {
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;
          nativeBuildInputs = [ pkgs.pkg-config ];
          buildInputs = [ pkgs.openssl ];
        };

        codex-acp = pkgs.rustPlatform.buildRustPackage ({
          pname = "codex-acp";
          version = "0.1.0";
          cargoBuildFlags = [ ]; # имя пакета из cli/Cargo.toml
        } // commonArgs);
      in {
        packages = {
          default = codex-acp;
        };
      }
    );
}
