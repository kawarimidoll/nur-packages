# Version Update Flow:
#
# Auto-updated:
#   - nvfetcher.toml src.manual (version) - by Renovate (github-releases)
#   - _sources/generated.nix (source hash) - by nvfetcher
#   - README.md packages table - by sync-readme
#
# This package uses `uv tool install` at runtime to install plamo-translate-cli.
# Reason: nixpkgs mlx is built without Metal (GPU) support because the `metal`
# command-line tool is proprietary (part of Xcode) and cannot be used in Nix sandbox.
# uv builds mlx with Metal support using the native Xcode installation.
#
# Note: macOS (Apple Silicon) only - requires Xcode for Metal support
{
  lib,
  writeShellApplication,
  uv,
  sources,
}:
writeShellApplication {
  name = "plamo-translate";

  runtimeInputs = [ uv ];

  derivationArgs = {
    inherit (sources.plamo-translate) version;
  };

  text = ''
    UV_TOOL_BIN="$HOME/.local/bin/plamo-translate"

    # Install via uv if not already installed
    if [[ ! -x "$UV_TOOL_BIN" ]]; then
      echo "plamo-translate not found. Installing via uv..." >&2
      uv tool install --force plamo-translate >&2
      echo "Installation complete." >&2
    fi

    # Ensure TMPDIR is set (required by plamo-translate)
    export TMPDIR="''${TMPDIR:-/tmp}"

    # Execute the real binary
    exec "$UV_TOOL_BIN" "$@"
  '';

  meta = {
    description = "A CLI for translation using the plamo-2-translate model with local execution";
    homepage = "https://github.com/pfnet/plamo-translate-cli";
    license = lib.licenses.asl20;
    mainProgram = "plamo-translate";
    platforms = lib.platforms.darwin;
  };
}
