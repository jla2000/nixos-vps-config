{ pkgs, ... }:
let
  listenPort = 51820;
  networkInterface = "enp0s1";
  wireguardInterface = "wg0";
in 
{
  networking.nat.enable = true;
  networking.nat.externalInterface = networkInterface;
  networking.nat.internalInterfaces = [ wireguardInterface ];
  networking.firewall.allowedUDPPorts = [ listenPort ];

  networking.wireguard.interfaces.${wireguardInterface} = {
    ips = [ "10.100.0.1/24" ];
    inherit listenPort;

    postSetup = ''
      ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o ${networkInterface} -j MASQUERADE
    '';

    postShutdown = ''
      ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o ${networkInterface} -j MASQUERADE
    '';

    privateKeyFile = "/root/wireguard-keys/private-server";

    peers = [
      {
        publicKey = "M3sd2dVfWfdH3CaTR4OYe0Zf4AtM9Zk5jjqULNPR0zk=";
        allowedIPs = [ "10.100.0.2/32" ];
      }
    ];
  };
}
