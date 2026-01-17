{
  lib,
  rustPlatform,
  makeWrapper,
  tree-sitter,
  sources,
}:
rustPlatform.buildRustPackage {
  pname = "kakehashi";
  version = sources.kakehashi.version;

  src = sources.kakehashi.src;

  cargoLock = {
    lockFile = "${sources.kakehashi.src}/Cargo.lock";
  };

  nativeBuildInputs = [ makeWrapper ];

  # Tests require git and external language files not available in sandbox
  doCheck = false;

  postInstall = ''
    wrapProgram $out/bin/kakehashi \
      --prefix PATH : ${lib.makeBinPath [ tree-sitter ]}
  '';

  meta = {
    description = "A Tree-sitter based language server bridging languages, editors, and tools";
    homepage = "https://github.com/atusy/kakehashi";
    license = lib.licenses.mit;
    mainProgram = "kakehashi";
  };
}
