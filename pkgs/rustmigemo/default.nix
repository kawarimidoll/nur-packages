# Version Update Flow:
#
# Manual update required (fork without releases):
#   - nvfetcher.toml uses src.git with branch tracking
#   - Run `nix run .#nvfetcher` to update when fork is updated
#   - Consider switching to upstream when fix is merged
#
# Dictionary update:
#   - Update migemo-dict rev/hash below when dictionary is updated
#   - Rust compilation is cached, only dictionary is re-fetched
{
  lib,
  rustPlatform,
  fetchFromGitHub,
  makeWrapper,
  sources,
}:
let
  migemo-dict = fetchFromGitHub {
    owner = "oguna";
    repo = "migemo-compact-dict-latest";
    rev = "043c04bf2c0be8a730c25c9ecfb08265dd0d340c";
    hash = "sha256-CNdtL9TlveieNzwbLrM7tA+bC8yUyNy90JTI2j8+imE=";
  };
in
rustPlatform.buildRustPackage {
  pname = "rustmigemo-wrapped";
  version = sources.rustmigemo.version;

  src = sources.rustmigemo.src;

  cargoLock = {
    lockFile = "${sources.rustmigemo.src}/Cargo.lock";
  };

  nativeBuildInputs = [ makeWrapper ];

  # Enable CLI feature to build the command-line tool
  buildFeatures = [ "cli" ];

  postInstall = ''
    wrapProgram $out/bin/rustmigemo-cli \
      --add-flags "-d ${migemo-dict}/migemo-compact-dict"
  '';

  meta = {
    description = "Migemo CLI with bundled dictionary (wrapped version)";
    homepage = "https://github.com/oguna/rustmigemo";
    license = lib.licenses.mit;
    mainProgram = "rustmigemo-cli";
  };
}
