{ pkgs, ... }: {
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ anthy ];
  };
  environment.systemPackages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
}
