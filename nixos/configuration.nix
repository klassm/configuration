	# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./config/defaults.nix
    ];
 
  boot.initrd.luks.devices = [
   {
     name = "root";
     device = "/dev/disk/by-uuid/2d350798-75d4-4a74-888c-6575aa68b0c8";
     preLVM = true;
     allowDiscards = true;
   }
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = false;
    };
    systemd-boot = {
      enable = true;
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
