{ pkgs, ... }: {
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager ];
  virtualisation.podman.enable = true;

  boot.binfmt.emulatedSystems =
    builtins.filter (system: system != pkgs.system) [
      "x86_64-linux"
      "aarch64-linux"
    ];
}
