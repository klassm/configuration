# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in {
  imports =
    [ # Include the results of the hardware scan.
      ./oh-my-zsh.nix
      ./klassm.nix
      ./desktop.nix
    ];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #
  environment.systemPackages = with pkgs; [ 
    thunderbird
    unstable.vim
    unstable.i3
    unstable.i3status
    unstable.ansible
    unstable.terraform
    nodejs-8_x
    i3lock xautolock
    unzip
    direnv
    docker
    flyway
    git
    openjdk
    peco
    python3
    redis
    rofi
    arandr
    tmux
    yarn
    gnupg
    pass
    ranger
    chromium
    roxterm
    wget curl tree
    unstable.tmux
    cryptsetup
    networkmanagerapplet
    gnome3.nautilus
    jetbrains.idea-ultimate
    xclip
    stow
    rxvt_unicode-with-plugins
    blueman volumeicon
    xfce.xfce4_power_manager_gtk3
    clipster
    lxappearance-gtk3
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
