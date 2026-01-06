{
  lib,
  rustPlatform,
  makeWrapper,
  tree-sitter,
  sources,
}:
rustPlatform.buildRustPackage {
  pname = "treesitter-ls";
  version = sources.treesitter-ls.version;

  src = sources.treesitter-ls.src;

  cargoLock = {
    lockFile = "${sources.treesitter-ls.src}/Cargo.lock";
  };

  nativeBuildInputs = [ makeWrapper ];

  # Tests require git and external language files not available in sandbox
  doCheck = false;

  postInstall = ''
    wrapProgram $out/bin/treesitter-ls \
      --prefix PATH : ${lib.makeBinPath [ tree-sitter ]}
  '';

  meta = {
    description = "A fast and flexible LSP server leveraging Tree-sitter";
    homepage = "https://github.com/atusy/treesitter-ls";
    license = lib.licenses.mit;
    mainProgram = "treesitter-ls";
  };
}
