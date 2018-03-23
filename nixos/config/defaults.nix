# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <unstable> {};

in  {
  imports =
    [ # Include the results of the hardware scan.
      ./oh-my-zsh.nix
      ./klassm.nix
      ./development.nix
      ./desktop.nix
    ];


  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = import /etc/nixos/config/pkgs;
  };

  environment.systemPackages = with pkgs; [ 
    zip unzip
    openjdk
    peco
    python3
    arandr
    gnupg
    ranger
    unstable.chromium
    wget curl tree
    cryptsetup
    unstable.tmux
    gnome3.nautilus
    stow
    rxvt_unicode-with-plugins
  ];

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      # allowedTCPPorts = [ 80 443 ];
      allowPing = false;
    };
    hostName = "lolonix";
  };

  security = {
    sudo.extraConfig = ''
      ALL  ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/systemctl suspend
      ALL  ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/systemctl reboot
      ALL  ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/systemctl poweroff
    '';
  };
}
