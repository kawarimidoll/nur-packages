# nur-packages

**kawarimidoll [NUR](https://github.com/nix-community/NUR) repository**

![Build](https://github.com/kawarimidoll/nur-packages/workflows/Build/badge.svg)

## Packages

<!-- packages-table-start -->
| Package | Version | Description |
|---------|---------|-------------|
| difit | v2.2.7 | A lightweight CLI tool to display Git diffs in GitHub-style web viewer |
| ghost | v0.3.0 | Simple background process manager for Unix systems |
| treesitter-ls | v0.0.2 | A fast and flexible LSP server leveraging Tree-sitter |
<!-- packages-table-end -->

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
  inputs.nur-packages.packages.${system}.treesitter-ls
];
```
