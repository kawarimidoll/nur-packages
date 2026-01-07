# Version Update Flow:
#
# Auto-updated:
#   - nvfetcher.toml src.manual (version) - by Renovate (github-releases)
#   - _sources/generated.nix (source hash) - by nvfetcher
#   - README.md packages table - by sync-readme
#
# Note: macOS (Apple Silicon) only - requires mlx-lm
# Use Python 3.12 to avoid mcp build issues with Python 3.13
{
  lib,
  python312,
  sources,
}:
let
  # Override Python package set to fix test/patch failures in sandbox
  python = python312.override {
    packageOverrides = self: super: {
      # portend tests require network access
      portend = super.portend.overridePythonAttrs (_: {
        doCheck = false;
      });
      # mcp has postPatch that doesn't apply to current version
      mcp = super.mcp.overridePythonAttrs (old: {
        postPatch = "";
        doCheck = false;
      });
    };
  };
  pythonPackages = python.pkgs;
in
pythonPackages.buildPythonApplication {
  inherit (sources.plamo-translate) pname version src;

  pyproject = true;

  build-system = [ pythonPackages.hatchling ];

  dependencies = with pythonPackages; [
    mcp
    numba
    mlx-lm
  ];

  # Tests require network access and model downloads
  doCheck = false;

  pythonImportsCheck = [ "plamo_translate" ];

  meta = {
    description = "A CLI for translation using the plamo-2-translate model with local execution";
    homepage = "https://github.com/pfnet/plamo-translate-cli";
    license = lib.licenses.asl20;
    mainProgram = "plamo-translate";
    platforms = lib.platforms.darwin;
  };
}
