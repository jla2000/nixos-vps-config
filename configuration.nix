{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/sshd.nix
    ./modules/minecraft.nix
    ./modules/wireguard.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-vps";

  environment.systemPackages = with pkgs; [
    neovim
    git
    lazygit
  ];

  system.stateVersion = "24.05";
}

