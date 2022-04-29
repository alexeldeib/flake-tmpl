{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    utils.url = "github:numtide/flake-utils";
    bundlers.url = "github:matthewbauer/nix-bundle";
    flake-compat = {
      url = github:edolstra/flake-compat;
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, bundlers, flake-compat }: utils.lib.eachDefaultSystem
    (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      with pkgs;
      {
        # Utilized by `nix build`
        packages = {
          default = stdenv.mkDerivation { };
        };

        defaultPackage = self.packages.${system}.default;

        # Utilized by `nix bundle -- .#<name>`
        # bundlers.default = bundlers.bundlers.${system}.toArx;
        # defaultBundler = self.bundlers.${system}.default;

        # Utilized by `nix develop`
        devShell = mkShell { };

        # # Utilized by `nix develop .#<name>`
        # devShells.example = self.devShell;

        # apps = { };

        # legacyPackages = { };

        # overlay = final: prev: { };

      });
}
