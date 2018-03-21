{ stdenv, fetchurl, pkgconfig, unzip, pkgs }:
#with import <nixpkgs> {};

stdenv.mkDerivation rec {
  version = "0.0.1";
  name = "zsh-peco-history-${version}";
  
  src = fetchurl {
    url = https://github.com/hamasho/zsh-peco-history/archive/d4edf90492c540dd1f1381138f6d369a8050534c.zip;
    sha256 = "ec81e34e20982b272517d4e507008a9411dd8d1ed8923a741a4cf9de8f3b89aa";
  };
  
  buildInputs = [ pkgconfig unzip ];
  
  installPhase = "cp -r . $out";

  meta = {
    description = "ZSH Peco History";
    homepage = https://github.com/hamasho/zsh-peco-history;
    license = "CCO 1.0";
  };
}

