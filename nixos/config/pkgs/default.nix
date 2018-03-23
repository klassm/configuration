pkgs:
let
  callPackage = pkgs.lib.callPackageWith(pkgs // custom);
  custom = {
    zsh-peco-history = callPackage ./zsh-peco-history {};
    roficlip = callPackage ./roficlip {};
  };
in custom
