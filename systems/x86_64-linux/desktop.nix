{ dotfiles, lib, modulesPath, config, ... }: {
  imports = with dotfiles.modules; [
    common
    personal
    gnome
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.enable = true;

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "nvme" "usbhid" "sr_mod" ];
  boot.kernelModules = [ "kvm-intel" ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/cf16872a-fdc0-4e5b-a2a1-e25570704e81";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/91A0-B3E1";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  fileSystems."/btrfs" = {
    device = "/dev/disk/by-uuid/cf16872a-fdc0-4e5b-a2a1-e25570704e81";
    fsType = "btrfs";
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/cf16872a-fdc0-4e5b-a2a1-e25570704e81";
    fsType = "btrfs";
    options = [ "subvol=@data" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/cf16872a-fdc0-4e5b-a2a1-e25570704e81";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/4bac7d29-7ff4-4acb-9ab3-ef16671750b1"; }];

  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
