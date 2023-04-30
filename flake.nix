{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";

  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    let
      user = "ruixi";
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule

      ];
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        #       packages.default = pkgs.hello;
      };
      flake = {
        nixosConfigurations = (
          import ./nixos {
            system = "x86_64-linux";
            inherit nixpkgs self inputs user;
          }
        );
      };
    };
}
