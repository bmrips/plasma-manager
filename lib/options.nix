{ config, lib, ... }:

let
  inherit (import ./types.nix { inherit config lib; }) attrsWith';
in
{
  shortcutSchemesOption = lib.mkOption {
    description = "Shortcut schemes.";
    default = { };
    type =
      let
        keys = with lib.types; either str (listOf str);
      in
      attrsWith' "scheme-name" (attrsWith' "action" keys);
  };
}
