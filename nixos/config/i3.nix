{ config, pkgs, ... }:

let
  unstable = import <unstable> {};

in {
  environment = {
    systemPackages = with pkgs; [
      unstable.i3
      unstable.i3status
      i3lock-fancy xautolock

      rofi rofi-pass roficlip fzf
    ];
  };
}
