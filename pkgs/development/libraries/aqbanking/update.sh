#!/bin/sh -e
basedir="$(cd "$(dirname "$0")" && pwd)"

getCurrentVersions() {
    [ -e "$basedir/sources.nix" ] || return 0
    (cd "$basedir" && nix-instantiate --eval --strict -E '
    toString ((import ../../../../lib).mapAttrsToList
        (name: info: "${name}:${info.version}!${info.sha256}!${info.releaseId}")
        (import ./sources.nix))
    ' | tr -d '"')
}

currentVersions="$(getCurrentVersions)"

getLastestVersion() {
    local baseurl="https://www.aquamaniac.de"
    local pkglist="sites/download/packages.php?package=$1&showall=1"
    local url="$baseurl/$pkglist"
    local reVersion='[0-9]+(\.[0-9]+)+' # Only release versions, no betas!
    local reHref='href=".*release=([0-9]+).*dummy=[^0-9]*('"$reVersion"')\.tar'
    local reFull='s/^.*<a\>.*\<'"$reHref"'.*/\2!\1/p'
    curl -s "$url" | sed -nre "$reFull" | sort -V -k 1,1 | tail -n1
}

getEntry() {
    local name="$1"
    for entry in $currentVersions; do
        if [ "${entry%%:*}" = "$name" ]; then
            echo "${entry#*:}"
            return 0
        fi
    done
    return 1
}

prefetchNew() {
    local name="$1"
    local version="$2"
    local package="$3"
    local releaseId="$4"

    local url="http://www.aquamaniac.de/sites/download/download.php"
    local qstring="package=$package&release=$releaseId&file=01";

    nix-prefetch-url --name "$name-$version.tar.gz" "$url?$qstring"
}

processPackage() {
    local name="$1"
    local package="$2"

    local latest="$(getLastestVersion "$package")"
    local current="$(getEntry "$name")"
    local currentTail="${current#*!}"

    local currentVersion="${current%%!*}"
    local currentSha256="${currentTail%%!*}"
    local currentReleaseId="${current##*!}"

    local latestVersion="${latest%%!*}"
    local latestReleaseId="${latest##*!}"

    if [ "$latestVersion" = "$currentVersion" -a \
         "$latestReleaseId" = "$currentReleaseId" ]; then
        echo "  $name.version = \"$currentVersion\";"
        echo "  $name.sha256 = \"$currentSha256\";"
        echo "  $name.releaseId = \"$currentReleaseId\";"
        return 0
    fi

    local latestSha256="$(
        prefetchNew "$name" "$latestVersion" "$package" "$latestReleaseId"
    )"

    echo "  $name.version = \"$latestVersion\";"
    echo "  $name.sha256 = \"$latestSha256\";"
    echo "  $name.releaseId = \"$latestReleaseId\";"
    return 0
}

generateNewSources() {
    echo "# This file is autogenerated from update.sh in the same directory."
    echo "{"
    for package in gwenhywfar:01 libchipcard:02 aqbanking:03; do
        processPackage "${package%%:*}" "${package##*:}"
    done
    echo "}"
}

if newSources="$(generateNewSources)"; then
    echo "$newSources" > "$basedir/sources.nix"
fi
