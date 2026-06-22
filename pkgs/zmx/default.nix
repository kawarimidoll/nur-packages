{
  lib,
  callPackage,
  system,
}:
callPackage ../build-support/prebuilt-binary.nix {
  inherit system;
  pname = "zmx";
  sourcesFile = ./sources.json;
  unpack = true; # tarball containing a single top-level file `zmx` (no directory)
  binaryInArchive = "zmx";
  meta = {
    description = "Session attach/detach for the terminal";
    homepage = "https://github.com/neurosnap/zmx";
    license = lib.licenses.mit;
    mainProgram = "zmx";
  };
}
