{ stdenv, fetchFromGitHub, ocaml, findlib, jbuilder
, ppx_fields_conv, ppx_sexp_conv, ppx_deriving
, base64, fieldslib, jsonm, logs, re, stringext, uri
}:

stdenv.mkDerivation rec {
	version = "1.0.0";
	name = "ocaml${ocaml.version}-cohttp-${version}";

	src = fetchFromGitHub {
		owner = "mirage";
		repo = "ocaml-cohttp";
		rev = "v${version}";
		sha256 = "0h9ak2bvhmcdxickvybpg45il33xszh2ksacpjgqrnnslxnh81ig";
	};

	buildInputs = [ ocaml findlib jbuilder jsonm ppx_fields_conv ppx_sexp_conv ];

	propagatedBuildInputs = [ ppx_deriving base64 fieldslib re stringext uri ];

	buildPhase = "jbuilder build -p cohttp";

	inherit (jbuilder) installPhase;

	meta = {
		description = "HTTP(S) library for Lwt, Async and Mirage";
		license = stdenv.lib.licenses.isc;
		maintainers = [ stdenv.lib.maintainers.vbgl ];
		inherit (src.meta) homepage;
		inherit (ocaml.meta) platforms;
	};
}
