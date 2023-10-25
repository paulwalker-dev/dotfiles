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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  hardware.bluetooth.settings = { General = { ControllerMode = "dual"; }; };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
