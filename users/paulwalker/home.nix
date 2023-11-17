{ config, pkgs, lib, ... }: {
  imports = [ ./hyprland.nix ];

  home.username = "paulwalker";
  home.packages = with pkgs; [
    firefox
    foliate
    go
    jetbrains.clion
    jetbrains.goland
    ledger
    pfetch
    prismlauncher
    signal-desktop
    webcord
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

    bash.enable = true;
    bash.bashrcExtra = ''
      [[ $(tty) = /dev/tty1 ]] && exec Hyprland
      PS1='\[\e[96m\]\u\[\e[37m\]@\[\e[92m\]\h \[\e[93m\]\W\n\[\e[90m\]\$ \[\e[0m\]'
      pfetch
    '';

    neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-surround
        vim-nix
        vim-ledger
        yuck-vim
      ];
      extraConfig = ''
        set shiftwidth=4 tabstop=4 expandtab
        set number relativenumber
      '';
    };

    git = {
      enable = true;
      userName = "Paul Walker";
      userEmail = "paulwalker@paulwalker.dev";
    };
  };

  home.stateVersion = "23.05";
}
