# Version Update Flow:
#
# Auto-updated (fully automatic):
#   - nvfetcher.toml src.manual (version) - by Renovate (npm datasource)
#   - _sources/generated.nix (source hash) - by nvfetcher
#   - README.md packages table - by sync-readme
#
# No manual update required - npm tarball contains pre-built files
{
  lib,
  stdenv,
  nodejs,
  makeWrapper,
  sources,
}:
stdenv.mkDerivation {
  inherit (sources.jsmigemo) pname version src;

  nativeBuildInputs = [ makeWrapper ];

  # npm tarball contains pre-built files, no build needed
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/node_modules/jsmigemo
    cp -r . $out/lib/node_modules/jsmigemo/

    mkdir -p $out/bin
    makeWrapper ${nodejs}/bin/node $out/bin/jsmigemo \
      --add-flags "$out/lib/node_modules/jsmigemo/bin/jsmigemo-cli.mjs"

    runHook postInstall
  '';

  meta = {
    description = "Migemo library for JavaScript - search Japanese text with Roman characters";
    homepage = "https://github.com/oguna/jsmigemo";
    license = lib.licenses.mit;
    mainProgram = "jsmigemo";
  };
}
