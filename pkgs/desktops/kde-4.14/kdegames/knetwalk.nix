{ kde, kdelibs, libkdegames }:
kde {
  buildInputs = [ kdelibs libkdegames ];
  meta = {
    description = "A small game where you have to build up a computer network by rotating the wires to connect the terminals to the server";
  };
}
