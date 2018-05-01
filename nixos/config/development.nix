{ config, pkgs, expr, buildVM, ... }:

let
  unstable = import <unstable> {};

in {
  nixpkgs.overlays =
      [
        (self: super:
         let
           name = "idea-ultimate-${version}";
           version = "2018.1.2";
           sha256 = "041swacdkcv6dp7y146ra4zm3vj66pgnphhg69ifq2y8v7yz1a60";
           oldVersion = "2018.1"; # super.lib.getVersion super.idea.idea-ultimate;
           overlayIsNewer =  super.lib.versionOlder oldVersion version;
         in if overlayIsNewer
            then {
              idea-ultimate = super.jetbrains.idea-ultimate.overrideAttrs ( oldAttrs: {
                inherit name version;
                src = super.fetchurl {
                  url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
                  inherit sha256;
                };
              });
            } else {
             idea-ultimate = super.jetbrains.idea-ultimate;
            }
        )
      ];

  environment.systemPackages =  let 
    myPythonPackages = pythonPackages: with pythonPackages; [
      pandas
      requests
      setuptools
      pyopenssl
      pip
      docopt
      pillow
      requests
      bz2file
      schema
      colorama
      pytz
      argparse
      requests-toolbelt
      defusedxml
      oauthlib
      requests_oauthlib
      virtualenvwrapper
  ]; 
  in with pkgs; [
    (python3.withPackages myPythonPackages)
    terraform-fixed
    unstable.ansible
    redis
    docker docker_compose
    unstable.flyway
    git
    idea-ultimate
    unstable.android-studio
    figlet hashdeep
    unstable.yarn
    jq
    unstable.virtualbox
    virtmanager qemu aqemu libvirt
    gw
    awscli
    gettext
    postgresql
    scaleft-client-tools
    openssl
    phantomjs2
    graphviz
    autojump
    gcc
    gnumake
    openssl
    openssl.dev
    readline
    zlib
    leiningen
  ];
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.extraOptions = ["-l"];
  virtualisation.libvirtd.extraConfig = "listen_tls = 0\nlisten_tcp = 1";
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  #nixpkgs.config.virtualbox.enableExtensionPack = true;


  networking.extraHosts = "127.0.0.1 test.local";
  boot.kernelModules = [ "kvm-intel" ];
}

