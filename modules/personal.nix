{ modules, ... }: {
  imports = [ modules.home-manager ];

  services.printing.enable = true;
  programs.dconf.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
