{ stdenv, fetchFromGitHub, fetchpatch, cmake, ninja, curl
, gettext, glib, gnome3, gst_all_1, json_glib
, libaccounts-glib, libnotify, libsecret, vala_0_38
, libxmlxx, wrapGAppsHook, pkgconfig, sqlite
}:

let
  pname = "FeedReader";
  version = "2.0.2";
in stdenv.mkDerivation {
  name = pname + "-" + version;

  src = fetchFromGitHub {
    owner = "jangernert";
    repo = pname;
    rev = "v" + version;
    sha256 = "1jhhbkgknnv4smj5imvflsk9fmr2kgqgcxr967ih1gq1dyh4pii8";
  };

  patches = [
    # https://github.com/jangernert/FeedReader/issues/593
    ./webkitgtk.patch
    # https://github.com/jangernert/FeedReader/issues/410
    (fetchpatch {
      url = https://github.com/jangernert/FeedReader/commit/eb2dc5a27e9d5883b726fb767daba994bae6662c.patch;
      sha256 = "0qc63pym43szpi110ki0w61f1a5r3rnwjhrgqcrildabi7ax9y3z";
    })
  ];

  nativeBuildInputs = [ cmake ninja pkgconfig gettext vala_0_38 wrapGAppsHook ];

  buildInputs = [
    curl glib json_glib libaccounts-glib libnotify libsecret
    libxmlxx sqlite
  ] ++
  (with gnome3; [
    gnome_online_accounts gtk libgee libpeas libsoup rest webkitgtk gsettings_desktop_schemas
  ]) ++
  (with gst_all_1; [
    gstreamer gstreamermm
  ]);

  postInstall = ''
    glib-compile-schemas $out/share/glib-2.0/schemas
  '';

  meta = with stdenv.lib; {
    description = "A modern desktop application designed to complement existing web-based RSS accounts.";
    homepage = https://jangernert.github.io/FeedReader/;
    platforms = platforms.linux;
    maintainers = with maintainers; [ edwtjo ];
  };
}
