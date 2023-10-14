{ config, pkgs, lib, hostname, ... }: {
  home.username = "paulwalker";
  home.packages = with pkgs; [
    discord
    firefox
    foliate
    iosevka
    ledger
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/background" = {
        picture-uri = "${./wallpaper.jpg}";
        picture-uri-dark = "${./wallpaper.jpg}";
      };
      "org/gnome/desktop/interface" = {
        clock-format = "12h";
      };
      "org/gnome/desktop/peripherals/mouse" = { accel-profile = "flat"; };
    };
  };

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
        name = "Iosevka";
        size = 10;
      };
    };

    bash.enable = true;

    neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
	vim-surround
        vim-nix
      ];
    };

    git = {
      enable = true;
      userName = "Paul Walker";
      userEmail = "paulwalker@paulwalker.dev";
    };
  };

  home.stateVersion = "23.05";
}
