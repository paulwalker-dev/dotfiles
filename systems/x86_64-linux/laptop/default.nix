{ modules, lib, modulesPath, config, ... }: {
  imports = [
    modules.common
    modules.personal
    modules.gnome
    modules.tailscale
    modules.gaming
    modules.virt
    modules.disko
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./disk.nix { disks = [ "/dev/sda" "/dev/sdb" ]; })
  ];

  networking.firewall.enable = true;
  networking.hosts = {
    "140.82.112.3" = [ "github.com" ];
    "13.33.4.2" = [ "crates.io" ];
    "146.75.38.137" = [ "static.crates.io" ];
    "172.253.115.141" = [ "sum.golang.org" ];
  };

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd amdgpu" ];

  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
