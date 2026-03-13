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
      mkHome = { system, username }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = false;
          };
          extraSpecialArgs = {
            inherit username;
          };
          modules = [ ./home/remote.nix ];
        };
    in {
      homeConfigurations = {
        ffettes = mkHome {
          system = "aarch64-darwin";
          username = "ffettes";
        };
        ffettes-mac = mkHome {
          system = "aarch64-darwin";
          username = "ffettes";
        };
        ffettes-linux = mkHome {
          system = "x86_64-linux";
          username = "exedev";
        };
      };
    };
}
