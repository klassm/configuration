pkgs:
let
  callPackage = pkgs.lib.callPackageWith(pkgs // custom);
  custom = {
    zsh-peco-history = callPackage ./zsh-peco-history {};
    roficlip = callPackage ./roficlip {};
    hashdeep = callPackage ./hashdeep {};
    gw = callPackage ./gw {};
  };
in custom
