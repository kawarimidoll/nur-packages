{
  lib,
  rustPlatform,
  sources,
}:
rustPlatform.buildRustPackage {
  pname = "ghost";
  version = sources.ghost.version;

  src = sources.ghost.src;

  cargoLock = {
    lockFile = "${sources.ghost.src}/Cargo.lock";
  };

  # Tests require network/process access not available in sandbox
  doCheck = false;

  meta = {
    description = "Simple background process manager for Unix systems";
    homepage = "https://github.com/skanehira/ghost";
    license = lib.licenses.mit;
    mainProgram = "ghost";
  };
}
