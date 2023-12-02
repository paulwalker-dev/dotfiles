{ inputs, ... }: {
  imports = [ inputs.disko.nixosModules.disko ];

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
}