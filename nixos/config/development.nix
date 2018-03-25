{ config, pkgs, expr, buildVM, ... }:

let
  unstable = import <unstable> {};

in {
  environment.systemPackages = with pkgs; [
    unstable.terraform
    nodejs-8_x
    unstable.ansible
    redis
    docker
    direnv
    flyway
    git
    jetbrains.idea-ultimate
    unstable.android-studio
    figlet hashdeep
    yarn
    jq
    virtualbox
    virtmanager qemu aqemu libvirt
    gw
    awscli
  ];
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.extraOptions = ["-l"];
  virtualisation.libvirtd.extraConfig = "listen_tls = 0\nlisten_tcp = 1";
  boot.kernelModules = [ "kvm-intel" ];
}

