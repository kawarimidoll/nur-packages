{
  lib,
  rustPlatform,
  sources,
}:
rustPlatform.buildRustPackage {
  pname = "lolcrab";
  version = sources.lolcrab.version;

  src = sources.lolcrab.src;

  cargoLock = {
    lockFile = "${sources.lolcrab.src}/Cargo.lock";
  };

  meta = {
    description = "Like lolcat but with noise and more colorful";
    homepage = "https://github.com/mazznoer/lolcrab";
    license = lib.licenses.mit;
    mainProgram = "lolcrab";
  };
}
