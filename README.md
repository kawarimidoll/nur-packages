# nur-packages

**kawarimidoll [NUR](https://github.com/nix-community/NUR) repository**

![Build](https://github.com/kawarimidoll/nur-packages/workflows/Build/badge.svg)

## Packages

<!-- packages-table-start -->
| Package | Version | Description |
|---------|---------|-------------|
| difit | v2.2.7 | A lightweight CLI tool to display Git diffs in GitHub-style web viewer |
| ghost | v0.3.0 | Simple background process manager for Unix systems |
| jsmigemo | 0.4.8 | Migemo library for JavaScript - search Japanese text with Roman characters |
| lolcrab | v0.4.1 | Like lolcat but with noise and more colorful |
| plamo-translate | 1.0.5 | A CLI for translation using the plamo-2-translate model with local execution |
| rustmigemo | 561a792bdbc5023d903198fed0cdbf8ad5fb6dc7 | Migemo library and CLI written in Rust |
| rxpipes | v1.3.0 | 2D recreation of the ancient Pipes screensaver for terminals |
| stormy | v0.3.3 | A minimal, customizable neofetch-like weather CLI |
| tree-sitter-ls | v0.0.8 | A fast and flexible LSP server leveraging Tree-sitter |
<!-- packages-table-end -->

### Notes

- **plamo-translate**: This package uses `uv tool install` at runtime instead of
  a pure Nix build. This is because nixpkgs' mlx package lacks Metal (GPU)
  support, which makes translation unusably slow. The wrapper installs the tool
  via uv on first run, requiring network access and Xcode for Metal support.

## Usage

Add this repository to your flake inputs:

```nix
{
  inputs.nur-packages = {
    url = "github:kawarimidoll/nur-packages";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

Then use the packages:

```nix
home.packages = [
  inputs.nur-packages.packages.${system}.ghost
  inputs.nur-packages.packages.${system}.tree-sitter-ls
];
```
