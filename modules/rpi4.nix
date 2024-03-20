{ dotfiles, pkgs, lib, ... }: {
  imports = with dotfiles.inputs; [
    nixos-hardware.nixosModules.raspberry-pi-4
    "${dotfiles.nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
  ];

  hardware.raspberry-pi."4" = {
    apply-overlays-dtmerge.enable = true;
    fkms-3d.enable = true;
  };

  console.enable = true;
  environment.systemPackages = with pkgs; [ raspberrypi-eeprom libraspberrypi ];

  sdImage.compressImage = false;
}
