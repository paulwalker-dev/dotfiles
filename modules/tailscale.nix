{ pkgs, ... }: {
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  environment.systemPackages = with pkgs; [ tailscale ];
  services.tailscale.enable = true;

  networking.firewall.checkReversePath = "loose";
}
