{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "wallpaper";

  src = pkgs.fetchurl {
    url = "https://osx.photo/assets/A_La_Carte/6K/Lion(6K)(v2).jpg";
    hash = "sha256-PjF3tQhq8VGifuR3rgyshYrKACQHI92YaMFqnaoKpmY=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp $src $out/wallpaper.jpg
  '';
}
