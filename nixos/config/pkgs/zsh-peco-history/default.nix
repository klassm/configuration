{ stdenv, fetchgit, pkgconfig, pkgs }:

stdenv.mkDerivation rec {
  version = "0.0.1";
  name = "zsh-peco-history-${version}";

  src = fetchgit {
    url = "git://github.com/hamasho/zsh-peco-history";
    rev = "d4edf90492c540dd1f1381138f6d369a8050534c";
  };
  
  buildInputs = [ pkgconfig ];
  
  installPhase = "cp -r . $out";

  meta = {
    description = "ZSH Peco History";
    homepage = https://github.com/hamasho/zsh-peco-history;
    license = "CCO 1.0";
  };
}

