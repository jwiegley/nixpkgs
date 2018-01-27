#! /usr/bin/env nix-shell
#! nix-shell -p 'lua5_2.withPackages(ps: [ ps.luarocks-nix ])' nix-prefetch-scripts -i bash

# You'll likely want to use
# ``
# nixpkgs $ maintainers/scripts/update-luarocks-packages.sh pkgs/top-level/lua-generated-packages.nix
# ``
# to update all libraries in that folder.

# Possible improvements:
# browse rocks here
# https://github.com/luarocks/luarocks/wiki/Browse-rocks
# we might be able to download rocks from
# http://luafr.org/moonrocks/ or
# https://github.com/rocks-moonscript-org/moonrocks-mirror.git

# set -eu -o pipefail

if [ $# -lt 1 ]; then

    echo "Usage: $0 GENERATED_FILENAME"
    exit 1
fi

GENERATED_NIXFILE="$1"

exit_trap()
{
  local lc="$BASH_COMMAND" rc=$?
  test $rc -eq 0 || echo "*** error $rc: $lc"
}

trap exit_trap EXIT



read -d '' -r HEADER <<EOM
/* ${GENERATED_NIXFILE} is an auto-generated file -- DO NOT EDIT!
Regenerate it with:
nixpkgs$ ${0} ${GENERATED_NIXFILE}
*/
{
# self has buildLuaPackage
self
, stdenv
, fetchurl
, fetchgit
, toLuaModule
, requiredLuaModules
}:
with self;
rec {
EOM

read -d '' -r FOOTER <<'EOM'
}
/* GENERATED */
EOM



# passing arrays is not easy
# expects 2 args
#  - pkgs list
#  - server or ""
function convert_pkgs () {
	local -n pkg_list=$1
	server=""
	if [ ! -z "$2" ]; then
		server=" --server=$2"
	fi

	# shift
	for pkg in "${pkg_list[@]}"
	do
		echo "looking at $pkg" >&2
		luarocks convert2nix $server "$pkg"
        if [ $? -gt 0 ]; then
            echo "Failed to convert $pkg" >&2
            # TODO here we could have a flag to pack and upload missing src.rock
            # to a nixos luarock manifest
        fi
	done
}


declare -a pkg_list_main
declare -a pkg_list_extra
pkg_list_main=(
ansicolors # -1.0.2-3
busted # -2.0.rc9-0 # OK
dkjson # -2.5-2 # looks ok
lua-cmsgpack # -0.4.0-0 # looks OK
lua_cliargs # -1.1-1 # OK
luassert # -1.7.9-0 # OK
lua-term # -0.7-1 #
luasocket # -2.0.2-6
ltermbox # -0.2-1 # ok
# mediator_lua # doesnt exist as source yet
luafilesystem # required by penlight
penlight
say # -1.3-1 # builtin type, check how luarocks handles modules
)
# ~/busted-2.0.rc12-1.rockspec

# basically don't have a src.pack version in
pkg_list_extra=(
mediator_lua
mpack
)


echo "$HEADER"
convert_pkgs pkg_list_main
convert_pkgs pkg_list_extra "http://luarocks.org/manifests/teto"
echo "$FOOTER" # close the set
