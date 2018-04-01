{ config, pkgs, ... }:

let
  unstable = import <unstable> {};

in {
  imports =
    [ # Include the results of the hardware scan.
      ./oh-my-zsh.nix
    ];

  environment = {
    systemPackages = with pkgs; [
      unstable.vim
      unstable.tmux
      ranger
      wget curl tree
      rxvt_unicode-with-plugins
      peco
      binutils
      direnv
      psmisc
    ];
  };
}
