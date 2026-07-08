{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (import ../../lib/options.nix { inherit config lib; }) shortcutSchemesOption;
in
{
  options.programs.dolphin = {
    enable = lib.mkEnableOption "Dolphin";
    package = lib.mkPackageOption pkgs [ "kdePackages" "dolphin" ] { nullable = true; };
    shortcutSchemes = shortcutSchemesOption;
  };

  config =
    let
      cfg = config.programs.dolphin;
    in
    lib.mkIf cfg.enable {
      home.packages = lib.mkIf (cfg.package != null) [ cfg.package ];
      programs.plasma.shortcutSchemes.dolphin = cfg.shortcutSchemes;
    };
}
