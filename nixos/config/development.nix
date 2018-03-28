{ config, pkgs, expr, buildVM, ... }:

let
  unstable = import <unstable> {};

in {
  environment.systemPackages = with pkgs; [
    terraform-fixed
    nodejs-8_x
    unstable.ansible
    redis
    docker docker_compose
    direnv
    unstable.flyway
    git
    jetbrains.idea-ultimate
    unstable.android-studio
    figlet hashdeep
    unstable.yarn
    jq
    virtualbox
    virtmanager qemu aqemu libvirt
    gw
    awscli
    gettext
    postgresql
    scaleft-client-tools
    binutils
    openssl
  ];
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.extraOptions = ["-l"];
  virtualisation.libvirtd.extraConfig = "listen_tls = 0\nlisten_tcp = 1";
  virtualisation.docker.enable = true;

  boot.kernelModules = [ "kvm-intel" ];
}

