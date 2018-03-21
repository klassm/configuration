{ config, pkgs, expr, buildVM, ... }:

{
  environment.systemPackages = with pkgs; [
    arc-theme arc-icon-theme
    elementary-icon-theme
    pulseaudioFull pasystray
    pavucontrol
    zoom-us
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

