{ modules, lib, modulesPath, config, ... }: {
  imports = [
    modules.common
    modules.tailscale
    modules.secureboot
    modules.gnome
    modules.home-manager
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.enable = true;

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd amdgpu" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c8be7a81-7aec-4e0e-b528-7a89007aeec2";
    fsType = "btrfs";
    options = [ "subvol=root" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/c8be7a81-7aec-4e0e-b528-7a89007aeec2";
    fsType = "btrfs";
    options = [ "subvol=home" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A0E3-2694";
    fsType = "vfat";
    options = [ "umask=077" ];
  };

  swapDevices = [{
    device = "/swapfile";
    size = 16000;
  }];

  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}