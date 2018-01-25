{ pkgs
, python3
, kernelDefinitions ? null
}:

let

  jupyterPath = (pkgs.jupyterKernels  kernelDefinitions);

in

with python3.pkgs; toPythonModule (
  notebook.overrideAttrs(oldAttrs: {
    makeWrapperArgs = ["--set JUPYTER_PATH ${jupyterPath}"];
  })
)
