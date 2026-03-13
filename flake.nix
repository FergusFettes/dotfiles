{
  description = "Fergus's minimal remote bootstrap";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      mkHome = system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = false;
          };
          modules = [ ./home/remote.nix ];
        };
    in {
      homeConfigurations = {
        ffettes = mkHome "aarch64-darwin";
        ffettes-linux = mkHome "x86_64-linux";
        ffettes-mac = mkHome "aarch64-darwin";
      };
    };
}
