{ config, pkgs, expr, buildVM, ... }:

{
  environment.systemPackages = with pkgs; [
    arc-theme arc-icon-theme
    elementary-icon-theme
    pnmixer aumix pamix
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
}

