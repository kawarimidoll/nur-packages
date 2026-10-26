{
  lib,
  callPackage,
  system,
}:
callPackage ../build-support/prebuilt-binary.nix {
  inherit system;
  pname = "zabrze";
  sourcesFile = ./sources.json;
  unpack = true; # tarball containing a single top-level file `zabrze` (no directory)
  binaryInArchive = "zabrze";
  meta = {
    description = "Zsh abbreviation expansion plugin";
    homepage = "https://github.com/Ryooooooga/zabrze";
    license = lib.licenses.mit;
    mainProgram = "zabrze";
  };
}
