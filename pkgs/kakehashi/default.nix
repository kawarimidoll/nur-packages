{
  lib,
  callPackage,
  system,
}:
callPackage ../build-support/prebuilt-binary.nix {
  inherit system;
  pname = "kakehashi";
  sourcesFile = ./sources.json;
  unpack = true; # tarball containing a single top-level file `kakehashi` (no directory)
  binaryInArchive = "kakehashi";
  meta = {
    description = "Language server that bridges the gap between languages, editors, and tooling";
    homepage = "https://github.com/atusy/kakehashi";
    license = lib.licenses.mit;
    mainProgram = "kakehashi";
  };
}
