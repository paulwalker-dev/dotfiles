{
  home = ./home.nix;
  admin = true;
  sshKeys = [ (builtins.readFile ./ssh/laptop) ];
}
