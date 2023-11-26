{ lib, pkgs, modules, users, inputs, name, ... }: {
  imports = [ modules.vm ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];

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

  environment.systemPackages = with pkgs; [ file pstree ];

  system.stateVersion = "23.05";
}
