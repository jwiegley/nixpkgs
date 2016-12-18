# Wrapper around wrapPythonProgramsIn, below. The $pythonPath
# variable is passed in from the buildPythonPackage function.
wrapPythonPrograms() {
    wrapPythonProgramsIn $out "$out $pythonPath"
}

# Builds environment variables like PYTHONPATH and PATH walking through closure
# of dependencies.
buildPythonPath() {
    local pythonPath="$1"
    local path

    # Create an empty table of python paths (see doc on _addToPythonPath
    # for how this is used). Build up the program_PATH and program_PYTHONPATH
    # variables.
    declare -A pythonPathsSeen=()
    program_PYTHONPATH=
    program_PATH=
    pythonPathsSeen["@python@"]=1
    addToSearchPath program_PATH @python@/bin
    for path in $pythonPath; do
        _addToPythonPath $path
    done
}

# Patches a Python script so that it has correct libraries path and executable
# name.
patchPythonScript() {
    local f="$1"

    # The magicalSedExpression will invoke a "$(basename "$f")", so
    # if you change $f to something else, be sure to also change it
    # in pkgs/indices/python-packages.nix!
    # It also uses $program_PYTHONPATH.
    sed -i "$f" -re '@magicalSedExpression@'
}

# Transforms any binaries generated by the setup.py script, replacing them
# with an executable shell script which will set some environment variables
# and then call into the original binary (which has been given a .wrapped
# suffix).
wrapPythonProgramsIn() {
    local dir="$1"
    local pythonPath="$2"
    local f

    buildPythonPath "$pythonPath"

    # Find all regular files in the output directory that are executable.
    for f in $(find "$dir" -type f -perm -0100); do
        # Rewrite "#! .../env python" to "#! /nix/store/.../python".
        # Strip suffix, like "3" or "2.7m" -- we don't have any choice on which
        # Python to use besides one with this hook anyway.
        if head -n1 "$f" | grep -q '#!.*/env.*\(python\|pypy\)'; then
            sed -i "$f" -e "1 s^.*/env[ ]*\(python\|pypy\)[^ ]*^#! @executable@^"
        fi

        # catch /python and /.python-wrapped
        if head -n1 "$f" | grep -q '/\.\?\(python\|pypy\)'; then
            # dont wrap EGG-INFO scripts since they are called from python
            if echo "$f" | grep -qv EGG-INFO/scripts; then
                echo "wrapping \`$f'..."
                patchPythonScript "$f"
                # wrapProgram creates the executable shell script described
                # above. The script will set PYTHONPATH and PATH variables.!
                # (see pkgs/build-support/setup-hooks/make-wrapper.sh)
                local -a wrap_args=("$f"
                                 --prefix PATH ':' "$program_PATH")

                # Add any additional arguments provided by makeWrapperArgs
                # argument to buildPythonPackage.
                local -a user_args="($makeWrapperArgs)"
                local -a wrapProgramArgs=("${wrap_args[@]}" "${user_args[@]}")
                wrapProgram "${wrapProgramArgs[@]}"
            fi
        fi
    done
}

# Adds the lib and bin directories to the PYTHONPATH and PATH variables,
# respectively. Recurses on any paths declared in
# `propagated-native-build-inputs`, while avoiding duplicating paths by
# flagging the directories it has visited in `pythonPathsSeen`.
_addToPythonPath() {
    local dir="$1"
    # Stop if we've already visited here.
    if [ -n "${pythonPathsSeen[$dir]}" ]; then return; fi
    pythonPathsSeen[$dir]=1
    # addToSearchPath is defined in stdenv/generic/setup.sh. It will have
    # the effect of calling `export program_X=$dir/...:$program_X`.
    addToSearchPath program_PYTHONPATH $dir/lib/@libPrefix@/site-packages
    addToSearchPath program_PATH $dir/bin

    # Inspect the propagated inputs (if they exist) and recur on them.
    local prop="$dir/nix-support/propagated-native-build-inputs"
    if [ -e $prop ]; then
        local new_path
        for new_path in $(cat $prop); do
            _addToPythonPath $new_path
        done
    fi
}

createBuildInputsPth() {
    local category="$1"
    local inputs="$2"
    if [ foo"$inputs" != foo ]; then
        for x in $inputs; do
            if $(echo -n $x |grep -q python-recursive-pth-loader); then
                continue
            fi
            if test -d "$x"/lib/@libPrefix@/site-packages; then
                echo $x/lib/@libPrefix@/site-packages \
                    >> "$out"/lib/@libPrefix@/site-packages/${name}-nix-python-$category.pth
            fi
        done
    fi
}
