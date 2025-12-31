{
  lib,
  rustPlatform,
  sources,
}:
rustPlatform.buildRustPackage {
  pname = "treesitter-ls";
  version = sources.treesitter-ls.version;

  src = sources.treesitter-ls.src;

  cargoLock = {
    lockFile = "${sources.treesitter-ls.src}/Cargo.lock";
  };

  # Tests require git and external language files not available in sandbox
  doCheck = false;

  meta = {
    description = "A fast and flexible LSP server leveraging Tree-sitter";
    homepage = "https://github.com/atusy/treesitter-ls";
    license = lib.licenses.mit;
    mainProgram = "treesitter-ls";
  };
}
