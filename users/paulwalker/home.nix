{ config, pkgs, lib, dotfiles, ... }: {
  #imports = [ dotfiles.inputs.nixvim.homeManagerModules.nixvim ];

  home.username = "paulwalker";
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Meslo" ]; })
    aerc
    anki
    discord
    firefox
    jetbrains-toolbox
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    rnote
    tmux
    vscode-fhs
    virt-viewer
  ];

  fonts.fontconfig.enable = true;

  services.syncthing.enable = true;

  programs = {
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    bash.enable = true;

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

    neovim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [ vim-surround vim-nix vim-ledger ];
      extraConfig = ''
        set shiftwidth=4 tabstop=4 expandtab
        set number relativenumber
      '';
    };

    #nixvim = {
    #  enable = true;
    #  plugins.surround.enable = true;
    #  opts = {
    #    number = true;
    #    relativenumber = true;
    #  };
    #};

    git = {
      enable = true;
      userName = "Paul Walker";
      userEmail = "paulwalker@paulwalker.dev";
    };
  };

  home.stateVersion = "23.05";
}
