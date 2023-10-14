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
    let d = builtins.readDir dir;
    in inputs.flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default =
          pkgs.mkShell { buildInputs = with pkgs; [ nixfmt ]; };
      }) // {
        users = builtins.listToAttrs (dirView /${dir}/users (n: name: {
          inherit name;
          value = import /${dir}/users/${n};
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
                specialArgs = {
                  inherit name inputs;
                  users = self.users;
                  modules = self.nixosModules;
                  secrets = /${dir}/secrets;
                };
                modules = [ /${dir}/systems/${system}/${n} ];
              };
            }))) (builtins.attrNames (builtins.readDir /${dir}/systems))));
      };
}
