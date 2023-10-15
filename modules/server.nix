{ users, ... }: {
  nix.settings.trusted-users = [ "admin" ];

  users.users.admin = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = builtins.concatLists
      (builtins.map (user: user.sshKeys)
        (builtins.filter (user: user.admin) (builtins.attrValues users)));
  };

  security.sudo.extraRules = [{
    users = [ "admin" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];
}
