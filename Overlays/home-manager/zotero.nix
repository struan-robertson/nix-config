final: prev: {
  zotero = prev.zotero.overrideAttrs (oldAttrs: rec {
    version = "7.0.0-beta.47%2Bf012a348a";
    src = prev.fetchurl {
      url =
        "https://download.zotero.org/client/beta/${version}/Zotero-${version}_linux-x86_64.tar.bz2";
      sha256 =
        "cd26517ad38c70b6ea07eaef747ebc9727dc60271f2299aa40856700b3150924";
    };

    postPatch = "";

    libPath = with prev;
      prev.lib.makeLibraryPath [
        stdenv.cc.cc
        atk
        cairo
        curl
        cups
        dbus-glib
        dbus
        fontconfig
        freetype
        gdk-pixbuf
        glib
        glibc
        gtk3
        xorg.libX11
        xorg.libXScrnSaver
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libxcb
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXi
        xorg.libXinerama
        xorg.libXrender
        xorg.libXt
        xorg.libXtst
        libnotify
        libGLU
        libGL
        nspr
        nss
        pango
        libffi
        alsa-lib
        poppler_utils
      ] + ":" + lib.makeSearchPathOutput "lib" "lib64" [ stdenv.cc.cc ];

    desktopItem = prev.makeDesktopItem {
      name = "zotero";
      exec = "zotero -url %U";
      icon = "zotero";
      comment = "Zotero Reference Management";
      desktopName = "Zotero";
      genericName = "Reference Management";
      categories = [ "Office" "Database" ];
      mimeTypes = [ "x-scheme-handler/zotero" "text/plain" ];
    };
  });
}
