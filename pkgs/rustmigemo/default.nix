{
  lib,
  rustPlatform,
  sources,
}:
rustPlatform.buildRustPackage {
  pname = "rustmigemo";
  version = sources.rustmigemo.version;

  src = sources.rustmigemo.src;

  cargoLock = {
    lockFile = "${sources.rustmigemo.src}/Cargo.lock";
  };

  # Enable CLI feature to build the command-line tool
  buildFeatures = [ "cli" ];

  meta = {
    description = "Migemo library and CLI written in Rust";
    homepage = "https://github.com/oguna/rustmigemo";
    license = lib.licenses.mit;
    mainProgram = "rustmigemo-cli";
  };
}
