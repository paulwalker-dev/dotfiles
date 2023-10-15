{
  home = ./home.nix;
  admin = true;
  sshKeys =
    [ (builtins.readFile ./ssh/laptop) (builtins.readFile ./ssh/desktop) ];
}
