{ stdenv, fetchgit, pkgconfig, pkgs }:

stdenv.mkDerivation rec {
  version = "0.0.1";
  name = "roficlip-${version}";

  src = fetchgit {
    url = "git://github.com/gilbertw1/roficlip";
    rev = "521369d12eab039e2c1a6418e1b9fa8eb5bd9126";
    sha256 = "0f4b2l3i3mxflahkbp4rbxni3bf92c6cpy4f94njhvg2v99w53p4";
  };
  
  buildInputs = [ pkgconfig ];
  
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

