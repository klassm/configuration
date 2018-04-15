{ config, pkgs, expr, buildVM, ... }:

let
  unstable = import <unstable> {};

in {
  nixpkgs.overlays =
      [
        (self: super:
         let
           name = "idea-ultimate-${version}";
           version = "2018.1";
           sha256 = "0n98gjm3v7qdyd1hc82zg57gyhwbamf27dyal1z71xfav4z5zb10";
           oldVersion = "2017.2.5"; # super.lib.getVersion super.idea.idea-ultimate;
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

  environment.systemPackages = with pkgs; [
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
  ];
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.extraOptions = ["-l"];
  virtualisation.libvirtd.extraConfig = "listen_tls = 0\nlisten_tcp = 1";
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  #nixpkgs.config.virtualbox.enableExtensionPack = true;

  boot.kernelModules = [ "kvm-intel" ];
}

