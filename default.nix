# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{
  pkgs ? import <nixpkgs> { },
}:
let
  sources = pkgs.callPackage ./_sources/generated.nix { };
in
{
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  difit = pkgs.callPackage ./pkgs/difit { inherit sources; };
  ghost = pkgs.callPackage ./pkgs/ghost { inherit sources; };
  lolcrab = pkgs.callPackage ./pkgs/lolcrab { inherit sources; };
  jsmigemo = pkgs.callPackage ./pkgs/jsmigemo { inherit sources; };
  rxpipes = pkgs.callPackage ./pkgs/rxpipes { inherit sources; };
  plamo-translate = pkgs.callPackage ./pkgs/plamo-translate { inherit sources; };
  rustmigemo = pkgs.callPackage ./pkgs/rustmigemo { inherit sources; };
  stormy = pkgs.callPackage ./pkgs/stormy { inherit sources; };
  kakehashi = pkgs.callPackage ./pkgs/kakehashi { inherit sources; };
}
