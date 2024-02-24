{ config, pkgs, lib, ... }: {
  home.username = "paulwalker";
  home.packages = with pkgs; [
    firefox
    ledger
    pfetch
    (nerdfonts.override { fonts = [ "Meslo" ]; })

    distrobox
    taskwarrior
    jetbrains-toolbox
  ];

  fonts.fontconfig.enable = true;

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/background" = (rec {
        picture-uri =
          "file://${pkgs.callPackage ./wallpaper.nix { }}/wallpaper.jpg";
        picture-uri-dark = picture-uri;
      });
    };
  };

  services.syncthing = {
    enable = true;
  };

  programs = {
    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    zoxide.enable = true;
    zoxide.options = ["--cmd cd"];

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
      pfetch
    '';

    neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [ vim-surround vim-nix vim-ledger ];
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
