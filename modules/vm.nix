{ options, lib, users, ... }:
lib.mkIf (options ? virtualisation.memorySize) {
  services.openssh.enable = lib.mkForce false;
  users.users =
    builtins.mapAttrs (_: _: { initialPassword = "password"; }) users;
}
