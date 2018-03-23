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
    thunderbird
    unstable.vim
    rofi rofi-pass roficlip fzf
    pass
    networkmanagerapplet
    blueman volumeicon
    xfce.xfce4_power_manager_gtk3
    clipster
    lxappearance-gtk3
    xclip
    unstable.i3
    unstable.i3status
    i3lock xautolock
    firefox
  ];
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "de";
    xkbOptions = "ctrl:nocaps, eurosign:e";
    libinput.enable = true;
    windowManager.i3.enable = true;
  
    displayManager.logToJournal = true;
    displayManager.lightdm.enable = true;
  };
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
}

