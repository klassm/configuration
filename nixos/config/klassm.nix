{ config, pkgs, lib, ... }:

let
  hasVBox = config.virtualisation.virtualbox.host.enable;
  hasDocker = config.virtualisation.docker.enable;
  hasnm = config.networking.networkmanager.enable;

in {
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
        "input" ]
        ++ pkgs.lib.optional hasnm "networkmanager"
        ++ pkgs.lib.optional hasVBox "vboxusers"
        ++ pkgs.lib.optional hasDocker "docker";
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
}
