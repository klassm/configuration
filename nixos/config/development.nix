{ config, pkgs, expr, buildVM, ... }:



 let
  unstable = import <unstable> {};
  in {
  nixpkgs.overlays =
      [
        (self: super:
         let
           name = "idea-ultimate-${version}";
           version = "2018.1.5";
           sha256 = "1mf57m3qypapkwniphlica4q49jal22aavxrbynsjgpcacvyq301";
           oldVersion = "2018.1"; # super.lib.getVersion super.idea.idea-ultimate;
           overlayIsNewer =  super.lib.versionOlder oldVersion version;
         in if overlayIsNewer
            then {
              idea-ultimate = super.jetbrains.idea-ultimate.overrideAttrs ( oldAttrs: {
                inherit name version;
                src = super.fetchurl {
                  url = "https://download-cf.jetbrains.com/idea/ideaIU-${version}.tar.gz";
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
    bzip2
    terraform-fixed
    unstable.ansible
    redis
    docker docker_compose
    unstable.flyway
    git
    idea-ultimate
    unstable.android-studio androidsdk
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
    wine winetricks cabextract
    packer
    nodePackages.gulp
    perlPackages.IOSocketSSL
    perlPackages.EmailOutlookMessage 
    avrdude
  ];
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.extraOptions = ["-l"];
  virtualisation.libvirtd.extraConfig = "listen_tls = 0\nlisten_tcp = 1";
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  #nixpkgs.config.virtualbox.enableExtensionPack = true;


  networking.extraHosts = ''
    127.0.0.1 test.local
    127.0.0.1 lolonix
  '';
  boot.kernelModules = [ "kvm-intel" ];
}

