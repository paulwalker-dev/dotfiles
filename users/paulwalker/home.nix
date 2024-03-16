{ config, pkgs, lib, ... }: {
  home.username = "paulwalker";
  home.packages = with pkgs; [
    firefox
    (nerdfonts.override { fonts = [ "Meslo" ]; })
  ];

  fonts.fontconfig.enable = true;

  programs = {
    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    kitty = {
      enable = true;
      settings = {
        disable_ligatures = "cursor";
        remember_window_size = false;
        initial_window_width = "80c";
        initial_window_height = "24c";
      };
      font = {
        name = "MesloLGS Nerd Font Mono";
        size = 10;
      };
    };

    git = {
      enable = true;
      userName = "Paul Walker";
      userEmail = "paulwalker@paulwalker.dev";
    };
  };

  home.stateVersion = "23.05";
}
