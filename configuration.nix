{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/sshd.nix
    ./modules/minecraft.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hetzner-vps";

  environment.systemPackages = with pkgs; [
    neovim
    git
    lazygit
  ];

  system.stateVersion = "24.05";
}

