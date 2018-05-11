# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <unstable> {};

in  {
  imports =
    [ # Include the results of the hardware scan.
      ./klassm.nix
      ./development.nix
      ./mail.nix
      ./desktop.nix
      ./i3.nix
      ./terminal.nix
    ];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = import /etc/nixos/config/pkgs;
  };

  environment.systemPackages = with pkgs; [ 
    zip unzip
    openjdk nodejs-8_x
    cryptsetup
    stow
    cron
    udiskie
    pass
    dpkg
    bind
    iptables
    traceroute
  ];

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 9592 8593 8594  9586 9089 9090 9091 9092 9093 9094 ];
      allowPing = true;
    };
    hostName = "lolonix";

    #bridges = {
    #    br0 = { interfaces = [ "enp62s0u1u4" ]; };
    #};
  };
  security = {
    sudo.extraConfig = ''
      ALL  ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/systemctl suspend
      ALL  ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/systemctl reboot
      ALL  ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/systemctl poweroff
    '';
  };
}
