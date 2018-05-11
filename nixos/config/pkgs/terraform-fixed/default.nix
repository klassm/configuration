{ stdenv, fetchurl, pkgconfig, unzip, pkgs }:

stdenv.mkDerivation rec {
  version = "0.11.7";
  name = "terraform-${version}";

  # Work around the "unpacker appears to have produced no directories"
  # case that happens when the archive doesn't have a subdirectory.
  setSourceRoot = "sourceRoot=`pwd`";

  src = fetchurl {
    url = "https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip";
    sha256 = "061lwac64rkgq920j1px947frpd0pi53170rf0zjm6x58xvfd33b";
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

