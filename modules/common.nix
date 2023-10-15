{ lib, pkgs, modules, users, inputs, name, overlays, ... }: {
  imports = [ modules.vm ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = overlays;

  networking.hostName = name;
  services.openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };

  users.users = builtins.mapAttrs (_:
    { admin, sshKeys, ... }: {
      isNormalUser = true;
      extraGroups = if admin then [ "wheel" ] else [ ];
      openssh.authorizedKeys.keys = sshKeys;
    }) users;

  system.stateVersion = "22.11";
}
