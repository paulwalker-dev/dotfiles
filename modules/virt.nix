{ pkgs, ... }: {
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager ];
  virtualisation.podman.enable = true;

  boot.binfmt.emulatedSystems = [
    "armv6l-linux"
  ];
}
