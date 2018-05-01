
{ config, pkgs, ... }:

let
  unstable = import <unstable> {};

in {
  environment = {
    systemPackages = with pkgs; [
      #neomutt # mutt-with-sidebar
      offlineimap msmtp gnupg abook# notmuch urlview
      sxiv
      procmail
      unstable.w3m
      thunderbird
    ];
  };
}
