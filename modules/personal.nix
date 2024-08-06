{ dotfiles, pkgs, ... }: {
  imports = with dotfiles.modules; [ home-manager ];

  services.flatpak.enable = true;
  services.tailscale.enable = true;
  programs.dconf.enable = true;

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = { General = { ControllerMode = "dual"; }; };
}
