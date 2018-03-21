pkgs:
let
  callPackage = pkgs.lib.callPackageWith(pkgs // custom);
  custom = {
    zsh-peco-history = callPackage ./zsh-peco-history {};
  };
in custom
