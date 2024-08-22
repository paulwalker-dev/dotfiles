{ config, pkgs, lib, dotfiles, darwin, ... }: {
  home.username = "paulwalker";
  home.packages = with pkgs; [ tmux ] ++ (if !darwin then [ firefox ] else [ ]);

  fonts.fontconfig.enable = true;

  programs = {
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    bash.enable = true;
    zsh.enable = true;

    git = {
      enable = true;
      userName = "Paul Walker";
      userEmail = "paulwalker@paulwalker.dev";
    };
  };

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
