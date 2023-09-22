{ config, lib, pkgs, ... }:

{
  final: prev: {
    zotero = prev.zotero.overrideAttrs (oldAttrs: rec {
      version = "7.0.0-beta.40%2B24ae34104";
      src = pkgs.fetchurl {
        url = "https://download.zotero.org/client/beta/${version}/Zotero-${version}_linux-x86_64.tar.bz2";
        sha256 = "e2bfcd1bab434f8b4d83269e86bb8aa797ee59bfd04d8b07874a1c68465f2c6f";
      };
      postPatch = '''';


    });
  }
}
