{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.nixos-vps = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [ 
        ./configuration.nix
        { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
      ];
    };
  };
}
