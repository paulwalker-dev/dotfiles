{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs.gnomeExtensions; [ appindicator ];
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ table ];
}
