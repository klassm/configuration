{ stdenv, fetchgit, pkgconfig, pkgs }:

stdenv.mkDerivation rec {
  version = "0.0.1";
  name = "gw-${version}";

  src = fetchgit {
    url = "git://github.com/klassm/gradle-wrapper";
    rev = "a7a877a8fdd25aa68413481cab81d362b41a2a3e";
  };

  buildInputs = [ pkgconfig ];
  
  installPhase = ''
    mkdir -p $out/bin
    cp -r ./gw $out/bin
  '';

  meta = {
    description = "gw";
  };
}

