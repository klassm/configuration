{ stdenv, fetchgit, pkgconfig, autoconf, automake, unzip, pkgs }:
#with import <nixpkgs> {};

stdenv.mkDerivation rec {
  version = "0.0.1";
  name = "hashdeep-${version}";
  
  src = fetchgit {
    url = "git://github.com/jessek/hashdeep";
    rev = "877613493ff44807888ce1928129574be393cbb0";
    sha256 = "0yjsv9sdf54q1qnspwva5hgwcb347vzarz1y1n88gjn1ayb9x8mv";
  };

  buildInputs = [ pkgconfig automake autoconf ];
  
  installPhase = ''
    sh bootstrap.sh
    ./configure --prefix=$out
    make
    make install
  '';

  meta = {
    description = "hashdeep";
    homepage = https://github.com/jessek/hashdeep;
  };
}

