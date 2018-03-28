{ stdenv, fetchurl, pkgconfig, unzip, pkgs }:

stdenv.mkDerivation rec {
  version = "0.11.4";
  name = "terraform-${version}";

  # Work around the "unpacker appears to have produced no directories"
  # case that happens when the archive doesn't have a subdirectory.
  setSourceRoot = "sourceRoot=`pwd`";

  src = fetchurl {
    url = "https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip";
    sha256 = "817be651ca41b999c09250a9fcade541a941afab41c0c663bd25529a4d5cfd31";
  };
  
  buildInputs = [ pkgconfig unzip ];

  installPhase = ''
    mkdir -p $out/bin
    cp ./terraform $out/bin
  '';

  meta = {
    description = "terraform";
    homepage = https://www.terraform.io;
  };
}

