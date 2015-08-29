{ stdenv, fetchurl, tcl, makeWrapper }:

let version = "5.45";
in
stdenv.mkDerivation {
  name = "expect-${version}";

  src = fetchurl {
    url = "mirror://sourceforge/expect/Expect/${version}/expect${version}.tar.gz";
    sha256 = "0h60bifxj876afz4im35rmnbnxjx4lbdqp2ja3k30fwa8a8cm3dj";
  };

  buildInputs = [ tcl ];
  nativeBuildInputs = [ makeWrapper ];

  patchPhase = ''
    sed -i "s,/bin/stty,$(type -p stty),g" configure
  '';

  configureFlags = [
    "--with-tcl=${tcl}/lib"
    "--with-tclinclude=${tcl}/include"
    "--exec-prefix=\${out}"
  ];

  postInstall =
    let darwinFlags =
      if stdenv.isDarwin
      then "--prefix DYLD_LIBRARY_PATH : $out/lib/expect${version}"
      else "";
    in ''
      for i in $out/bin/*; do
        wrapProgram $i \
          --prefix PATH : "${tcl}/bin" \
          --prefix TCLLIBPATH ' ' $out/lib/* \
          ${darwinFlags}
      done
    ''
  ;

  meta = with stdenv.lib; {
    description = "A tool for automating interactive applications";
    homepage = http://expect.nist.gov/;
    license = "Expect";
    platforms = platforms.unix;
    maintainers = with maintainers; [ wkennington ];
  };
}
