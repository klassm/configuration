{ config, pkgs, lib, ... }:

{
  users = {
    mutableUsers = true; # one needs to change the password?
    extraUsers.klassm = {
      isNormalUser = true;
      group = "klassm";
      uid = 1000;
      extraGroups = [
        "wheel"
        "audio" "video"
        "dialout"
        "input"
        "libvirtd"
        "docker"
        "vboxusers"
        "networkmanager" ];
      home = "/home/klassm";
      createHome = true;
      shell = "/run/current-system/sw/bin/zsh";
      initialPassword = lib.mkForce "dummy";
    };
    extraGroups.klassm.gid = 1000;
  };

  time.timeZone = "Europe/Berlin";
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "de";
    defaultLocale = "de_DE.UTF-8";
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * *      klassm    /home/klassm/.config/i3/random_wallpaper.sh > /tmp/random_wallpaper.log"
    ];
  };
}
