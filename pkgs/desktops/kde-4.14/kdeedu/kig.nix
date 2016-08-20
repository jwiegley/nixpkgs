{ kde, kdelibs, boost, python}:
kde {
  buildInputs = [ kdelibs boost python ];

  cmakeFlags = { KIG_ENABLE_PYTHON_SCRIPTING = true; };

  meta = {
    description = "KDE Interactive Geometry";
  };
}
