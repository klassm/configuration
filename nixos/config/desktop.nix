{ config, pkgs, expr, buildVM, ... }:

let
  unstable = import <unstable> {};

in {
  environment.systemPackages = with pkgs; [
    arc-theme arc-icon-theme
    elementary-icon-theme
    pulseaudioFull pasystray
    pavucontrol
    zoom-us
    gnome3.nautilus
    arandr
    gnupg
    networkmanagerapplet
    blueman volumeicon
    xfce.xfce4_power_manager_gtk3
    clipster
    lxappearance-gtk3
    xclip
    firefox unstable.chromium
    gparted
    gnome3.file-roller
    mirage
    shutter
  ];
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "de";
    xkbOptions = "ctrl:nocaps, eurosign:e";
    xkbVariant = "nodeadkeys";
    exportConfiguration = true;
    libinput.enable = true;
    windowManager.i3.enable = true;
    localectlFix.enable = true;

    displayManager.logToJournal = true;
    displayManager.lightdm.enable = true;
  };
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.bumblebee.enable = true;
}

