
{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      oh-my-zsh
      zsh-syntax-highlighting
      zsh-peco-history
    ];
    shells = ["/run/current-system/sw/bin/zsh"];
  };
  programs.zsh = {
    enable = true;
    interactiveShellInit = ''
export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

mkdir -p ~/.oh-my-zsh-cache
export ZSH_CACHE_DIR=~/.oh-my-zsh-cache

export ZSH_PECO_HISTORY=${pkgs.zsh-peco-history}/zsh-peco-history.plugin.zsh
source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
'';

    promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh
  };
}
