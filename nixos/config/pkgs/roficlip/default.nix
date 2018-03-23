{ stdenv, fetchurl, pkgconfig, unzip, pkgs }:
#with import <nixpkgs> {};

stdenv.mkDerivation rec {
  version = "0.0.1";
  name = "roficlip-${version}";
  
  src = fetchurl {
    url = "https://github.com/gilbertw1/roficlip/archive/master.zip";
    sha256 = "401492ec971060a2549359e48f2dac1205b17cb65d769000d7b935aa10f419bc";
  };
  
  buildInputs = [ pkgconfig unzip ];
  
  installPhase = ''
    mkdir -p $out/bin
    cp ./roficlip $out/bin/roficlip
  '';

  meta = {
    description = "roficlip";
    homepage = https://github.com/gilbertw1/roficlip;
    license = "GPL v.3";
  };
}

