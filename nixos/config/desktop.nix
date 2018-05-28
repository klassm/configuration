{ config, pkgs, expr, buildVM, ... }:

let
  unstable = import <unstable> {};

in {
  environment.systemPackages = with pkgs; [
    arc-theme arc-icon-theme lightdm
    ponymix
    elementary-icon-theme
    pulseaudioFull pasystray
    pavucontrol
    zoom-us
    gnome3.nautilus
    gnome3.gedit
    libcanberra_gtk3 gtk-engine-murrine
    arandr feh
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
    xorg.xmodmap xorg.xev acpid
    system-config-printer gutenprint hplip
    evince
    x11vnc
    spice-gtk
    gimp inkscape
    tightvnc
    calibre
    sshfs unrar telnet bridge-utils
    libreoffice
    google-chrome
    desktop-file-utils
    teamviewer
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
    desktopManager.xterm.enable = false;

    displayManager.job.logToJournal = true;
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

  services.acpid.enable = true;

  services.acpid.handlers.volumeDown = {
    event = "button/volumedown";
    action = "${pkgs.alsaUtils}/bin/amixer -c0 set Master 3%-";
  };
  services.acpid.handlers.volumeUp = {
    event = "button/volumeup";
    action = "${pkgs.alsaUtils}/bin/amixer -c0 set Master 3%+";
  };
  services.acpid.handlers.mute = {
    event = "button/mute";
    action = "${pkgs.alsaUtils}/bin/amixer set Master -c0 toggle";
  };

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.splix pkgs.gutenprint pkgs.hplip ];

  services.virtualbox.host = { enable = true; enableHardening = false; };

  networking.firewall.allowedTCPPorts = [ 5900 5901 5902 ];

  services.teamviewer.enable = true;
}

