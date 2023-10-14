{ lib, inputs, ... }: {
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  boot = {
    bootspec.enable = true;
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };
}
