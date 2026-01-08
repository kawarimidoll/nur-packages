{
  lib,
  buildGoModule,
  sources,
}:
buildGoModule {
  pname = "stormy";
  version = sources.stormy.version;

  src = sources.stormy.src;

  vendorHash = "sha256-iwgGAJRygi+xS5eorZ8wyR6pMDZvmGFXBbCiFazyaHw=";

  meta = {
    description = "A minimal, customizable neofetch-like weather CLI";
    homepage = "https://github.com/ashish0kumar/stormy";
    license = lib.licenses.mit;
    mainProgram = "stormy";
  };
}
