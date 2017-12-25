{ lib, writeScript, python3, common-updater-scripts }:
{ packageName, versionPolicy ? "odd-unstable" }:

let
  python = python3.withPackages (p: [ p.requests ]);
in writeScript "update-gnome-pkg" ''
PATH=${lib.makeBinPath [ common-updater-scripts python ]}
latest_tag=$(python "${./find-latest-version.py}" "${packageName}" stable "${versionPolicy}")
update-source-version "${packageName}" "$latest_tag"
''
