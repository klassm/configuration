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

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;

    # NixOS allows either a lightweight build (default) or full build of PulseAudio to be installed.
    # Only the full build has Bluetooth support, so it must be selected here.
    package = pkgs.pulseaudioFull;
  };
  hardware.bumblebee.enable = true;
  hardware.bluetooth.enable = true;
}

