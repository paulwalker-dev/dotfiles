{ dotfiles, pkgs, ... }: {
  imports = [ dotfiles.inputs.home-manager.darwinModules.home-manager ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit dotfiles;
    darwin = true;
  };

  users.users = builtins.mapAttrs (name:
    { ... }: {
      name = name;
      home = "/Users/${name}";
    }) dotfiles.users;

  home-manager.users =
    builtins.mapAttrs (_: { home, ... }: home) dotfiles.users;

  networking.hostName = dotfiles.hostname;

  programs.zsh.enable = true;

  system.stateVersion = 4;
}
