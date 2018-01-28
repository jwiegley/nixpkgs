addToLuaSearchPathWithCustomDelimiter() {
    local delimiter="$1"
    local varName="$2"
    local dir="$3"
    local suffix="$4"
    if  [ -d "$dir" ]; then
        export "${varName}=${!varName:+${!varName}${delimiter}}${dir}${suffix}"
    fi
}

addToLuaSearchPath() {
    addToLuaSearchPathWithCustomDelimiter ";" "$@"
}

startLuaEnvHook() {
addToLuaPath "$1"
}

# Adds the lib and bin directories to the LUA_PATH and PATH variables,
# respectively. Recurses on any paths declared in
# `propagated-native-build-inputs`, while avoiding duplicating paths by
# flagging the directories it has visited in `luaPathsSeen`.
addToLuaPath() {
    local dir="$1"

    addToLuaSearchPath LUA_PATH "$dir/lib/lua/@luaversion@" "/?.lua"
    addToLuaSearchPath LUA_PATH "$dir/share/lua/@luaversion@" "/?.lua"
    addToLuaSearchPath LUA_PATH "$dir/share/lua/@luaversion@" "/?/init.lua"
    addToLuaSearchPath LUA_PATH "$dir/lib/lua/@luaversion@" "/?/init.lua"
    addToLuaSearchPath LUA_CPATH "$dir/lib/lua/@luaversion@" "/?.so"
    addToLuaSearchPath LUA_CPATH "$dir/share/lua/@luaversion@" "/?.so"
}

addEnvHooks "$hostOffset" startLuaEnvHook

