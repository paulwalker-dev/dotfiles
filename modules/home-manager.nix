{ dotfiles, config, pkgs, ... }: {
  imports = [ dotfiles.inputs.home-manager.nixosModules.default ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit dotfiles;
    darwin = false;
  };

  home-manager.users =
    builtins.mapAttrs (_: { home, ... }: home) dotfiles.users;
}
