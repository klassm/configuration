{ stdenv, fetchurl, pkgconfig, binutils, pkgs }:
#with import <nixpkgs> {};

stdenv.mkDerivation rec {
  version = "1.33.2";
  name = "scaleft-client-tools-${version}";
  
  src = fetchurl {
    url = "http://pkg.scaleft.com/deb/pool/linux/main/s/scaleft-client-tools/scaleft-client-tools_${version}_amd64.deb";
    sha256 = "08a192c7342b885452890c8cceb3ae2331cea230bedf68757fcac2cf9efca1f3";
  };

  unpackCmd = ''
    ar p "$src" data.tar.gz | tar xz
  '';

  buildPhase = ":";   # nothing to build

  buildInputs = [ pkgconfig binutils ];

  installPhase = ''
    mkdir -p $out
    cp -r bin share $out/
  '';

 preFixup = ''
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      $out/bin/sft
  '';

  meta = {
    description = "scaleft-client-tools";
  };
}

