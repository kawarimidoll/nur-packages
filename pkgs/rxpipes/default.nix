{
  lib,
  rustPlatform,
  sources,
}:
rustPlatform.buildRustPackage {
  pname = "rxpipes";
  version = sources.rxpipes.version;

  src = sources.rxpipes.src;

  cargoLock = {
    lockFile = "${sources.rxpipes.src}/Cargo.lock";
  };

  meta = {
    description = "2D recreation of the ancient Pipes screensaver for terminals";
    homepage = "https://github.com/inunix3/rxpipes";
    license = lib.licenses.mit;
    mainProgram = "rxpipes";
  };
}
