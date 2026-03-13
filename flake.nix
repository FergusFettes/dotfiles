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
      system = builtins.currentSystem;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = false;
      };
    in {
      homeConfigurations.ffettes = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/remote.nix ];
      };
    };
}
