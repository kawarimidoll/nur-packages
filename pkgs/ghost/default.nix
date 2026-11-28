{
  lib,
  rustPlatform,
  sources,
  pkg-config,
  sqlite,
}:
rustPlatform.buildRustPackage {
  pname = "ghost";
  version = sources.ghost.version;

  src = sources.ghost.src;

  cargoLock = {
    lockFile = "${sources.ghost.src}/Cargo.lock";
  };

  # nixpkgs' cargo setup hook sets LIBSQLITE3_SYS_USE_PKG_CONFIG=1, overriding rusqlite's `bundled` feature
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ sqlite ];

  # Tests require network/process access not available in sandbox
  doCheck = false;

  meta = {
    description = "Simple background process manager for Unix systems";
    homepage = "https://github.com/skanehira/ghost";
    license = lib.licenses.mit;
    mainProgram = "ghost";
  };
}
