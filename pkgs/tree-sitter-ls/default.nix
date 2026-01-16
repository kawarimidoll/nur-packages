{
  lib,
  rustPlatform,
  makeWrapper,
  tree-sitter,
  sources,
}:
rustPlatform.buildRustPackage {
  pname = "tree-sitter-ls";
  version = sources.tree-sitter-ls.version;

  src = sources.tree-sitter-ls.src;

  cargoLock = {
    lockFile = "${sources.tree-sitter-ls.src}/Cargo.lock";
  };

  nativeBuildInputs = [ makeWrapper ];

  # Tests require git and external language files not available in sandbox
  doCheck = false;

  postInstall = ''
    wrapProgram $out/bin/tree-sitter-ls \
      --prefix PATH : ${lib.makeBinPath [ tree-sitter ]}
  '';

  meta = {
    description = "A fast and flexible LSP server leveraging Tree-sitter";
    homepage = "https://github.com/atusy/tree-sitter-ls";
    license = lib.licenses.mit;
    mainProgram = "tree-sitter-ls";
  };
}
