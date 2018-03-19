
{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      oh-my-zsh
      unstable.zsh-syntax-highlighting
    ];
    shells = ["/run/current-system/sw/bin/zsh"];
    variables = {
      OH_MY_ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
    };
  };
  programs.zsh = {
    enable = true;
    interactiveShellInit = ''
export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

mkdir -p ~/.oh-my-zsh-cache
export ZSH_CACHE_DIR=~/.oh-my-zsh-cache

mkdir -p ~/.oh-my-zsh-custom
export ZSH_CUSTOM=~/.oh-my-zsh-custom

source ${pkgs.unstable.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
'';

    promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh
  };
}
