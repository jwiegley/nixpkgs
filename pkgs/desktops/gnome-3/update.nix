{ runCommand, python3, common-updater-scripts }:
{ packageName, versionPolicy ? "odd-unstable" }:

let
  python = python3.withPackages (p: [ p.requests ]);
in runCommand "update-gnome-pkg" { buildInputs = [ common-updater-scripts python ]; inherit packageName versionPolicy; }''
latest_tag=$(python "${./find-latest-version.py}")
update-source-version "$packageName" "$latest_tag"
''
