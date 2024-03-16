{ dotfiles, lib, pkgs, modules, ... }: {
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
    }) dotfiles.users;

  system.stateVersion = "23.05";
}
