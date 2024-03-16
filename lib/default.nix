{ self, nixpkgs, ... }@inputs:
let
  dirView = dir: f:
    (builtins.map (n:
      let
        name = if nixpkgs.lib.hasSuffix ".nix" n then
          nixpkgs.lib.removeSuffix ".nix" n
        else
          n;
      in f n name) (builtins.attrNames (builtins.readDir dir)));
in {
  mkFlake = dir:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in { devShells.default = pkgs.callPackage /${dir}/shell.nix { }; }) // {
        users = builtins.listToAttrs (dirView /${dir}/users (n: name: {
          inherit name;
          value = (import /${dir}/users/${n}) // {
            sshKeys = if builtins.pathExists /${dir}/users/${name}/ssh then
              dirView /${dir}/users/${name}/ssh (keyname: _:
                (builtins.readFile /${dir}/users/${name}/ssh/${keyname}))
            else
              [ ];
          };
        }));

        nixosModules = builtins.listToAttrs (dirView /${dir}/modules (n: name: {
          inherit name;
          value = /${dir}/modules/${n};
        }));

        nixosConfigurations = builtins.listToAttrs (builtins.concatLists
          (builtins.map (system:
            (dirView /${dir}/systems/${system} (n: name: {
              inherit name;
              value = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs.dotfiles = {
                  inherit name inputs;
                  users = self.users;
                  modules = self.nixosModules;
                };
                modules = [ /${dir}/systems/${system}/${n} ];
              };
            }))) (builtins.attrNames (builtins.readDir /${dir}/systems))));
      };
}
