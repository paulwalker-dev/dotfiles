{ config, lib, pkgs, modules, modulesPath, ... }: {
  imports = [
    modules.common
    modules.tailscale
    modules.server
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  services.nginx = {
    enable = true;
    virtualHosts."www" = {
      serverName = "_";
      root = ./srv;
    };
  };

  networking.firewall.enable = false;

  # Hardware config
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  boot.initrd.availableKernelModules =
    [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
