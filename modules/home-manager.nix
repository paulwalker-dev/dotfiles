{ dotfiles, config, ... }: {
  imports = with dotfiles.inputs; [ home-manager.nixosModules.home-manager ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inputs = dotfiles.inputs; };

  home-manager.users =
    builtins.mapAttrs (_: { home, ... }: home) dotfiles.users;
}
