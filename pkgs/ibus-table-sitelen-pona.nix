{ lib, stdenv, fetchFromGitHub, ibus, ibus-engines }:
stdenv.mkDerivation rec {
  pname = "ibus-table-sitelen-pona";
  version = "2024-03-19";

  buildInputs = [ ibus ibus-engines.table ];

  src = fetchFromGitHub {
    owner = "neroist";
    repo = "sitelen-pona-ucsur-guide";
    rev = "9dfbef95f6c6535460c8c4bb4f855f9cabe43834";
    hash = "sha256-xUyxn/E/cAFoxfzyYOv0J35MOrzxYIeN2355zZ9vZ84=";
  };

  installPhase = ''
    export HOME=$(mktemp -d)
    mkdir -p $out/share/ibus-table/tables
    ibus-table-createdb -n $out/share/ibus-table/tables/sitelen-pona.db -s ibus-tables/sitelen-pona-4.0.ibus-table
    rm -rf $HOME
  '';

  meta = with lib; { isIbusEngine = true; };
}
