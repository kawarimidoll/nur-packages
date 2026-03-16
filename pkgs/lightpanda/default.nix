{
  lib,
  stdenvNoCC,
  fetchurl,
  autoPatchelfHook,
  system,
}:
let
  sources = lib.importJSON ./sources.json;
  platform = sources.platforms.${system} or (throw "Unsupported system: ${system}");
  baseUrl = "https://github.com/lightpanda-io/browser/releases/download/${sources.version}";
in
stdenvNoCC.mkDerivation {
  pname = "lightpanda";
  version = sources.version;

  src = fetchurl {
    url = "${baseUrl}/${platform.binary}";
    inherit (platform) hash;
  };

  dontUnpack = true;

  nativeBuildInputs = lib.optionals stdenvNoCC.hostPlatform.isLinux [ autoPatchelfHook ];

  installPhase = ''
    install -Dm755 $src $out/bin/lightpanda
  '';

  meta = {
    description = "Lightweight browser engine for AI agents and web automation";
    homepage = "https://github.com/lightpanda-io/browser";
    license = lib.licenses.agpl3Only;
    mainProgram = "lightpanda";
    platforms = builtins.attrNames sources.platforms;
  };
}
