{ config, pkgs, expr, buildVM, ... }:

let
  unstable = import <unstable> {};

in {
  environment.systemPackages = with pkgs; [
    unstable.terraform
    nodejs-8_x
    unstable.ansible
    redis
    docker
    direnv
    flyway
    git
    jetbrains.idea-ultimate
    figlet hashdeep
    yarn
    jq
  ];
}

