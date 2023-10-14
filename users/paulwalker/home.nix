{ config, pkgs, lib, hostname, ... }: {
  home.username = "paulwalker";
  home.packages = with pkgs; [
    discord
    firefox
    foliate
    iosevka
    jetbrains-toolbox
    ledger
    pfetch
  ];

  fonts.fontconfig.enable = true;

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/background" = {
        picture-uri = "${./wallpaper.jpg}";
        picture-uri-dark = "${./wallpaper.jpg}";
      };
      "org/gnome/desktop/interface" = {
        clock-format = "12h";
        #color-scheme = "prefer-dark";
      };
      "org.gnome.desktop.peripherals.mouse" = { accel-profile = "flat"; };
    };
  };

  programs = {
    starship.enable = true;
    eza = {
      enable = true;
      enableAliases = true;
    };

    go.enable = true;

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
      extraConfig = ''
        map ctrl+shift+enter launch --cwd=current
      '';
    };

    bash.enable = true;
    bash.initExtra = ''
      export PATH="$HOME/go/bin:$PATH"
      pfetch
    '';

    neovim = {
      enable = true;
      vimAlias = true;
      extraPackages = with pkgs; [ gcc nodejs ];
    };

    git = {
      enable = true;
      userName = "Paul Walker";
      userEmail = "paulwalker@paulwalker.dev";
    };
  };

  home.stateVersion = "23.05";
}
