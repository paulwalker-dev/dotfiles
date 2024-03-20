{ dotfiles, config, ... }: {
  imports = [ dotfiles.inputs.home-manager.nixosModules.home-manager ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit dotfiles; };

  home-manager.users =
    builtins.mapAttrs (_: { home, ... }: home) dotfiles.users;
}
