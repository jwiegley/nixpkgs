{ appleDerivation, libsecurity_asn1, libsecurity_cdsa_client, libsecurity_cdsa_plugin, libsecurity_cdsa_utilities, libsecurity_filedb, libsecurity_keychain, libsecurity_utilities, libsecurityd, osx_private_sdk }:
appleDerivation {
  buildInputs = [
    libsecurity_cdsa_plugin
    libsecurity_cdsa_utilities
    libsecurity_utilities
    libsecurityd
    libsecurity_cdsa_client
    libsecurity_keychain
    libsecurity_filedb
    libsecurity_asn1
  ];
  patchPhase = ''
    for file in lib/*; do
      sed -i 's/#include <\(.*\)>/#include "\1"/' ''$file
    done
  '';
}
