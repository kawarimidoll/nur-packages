{
  lib,
  stdenvNoCC,
  sources,
  makeWrapper,
  bash,
  git,
  coreutils,
  installShellFiles,
}:

stdenvNoCC.mkDerivation {
  pname = "git-worktree-runner";
  inherit (sources.git-worktree-runner) version src;

  nativeBuildInputs = [
    makeWrapper
    installShellFiles
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    # Install the entire project to share
    mkdir -p $out/share/git-worktree-runner
    cp -r bin lib adapters templates $out/share/git-worktree-runner/

    # Make scripts executable
    chmod +x $out/share/git-worktree-runner/bin/*

    # Create wrapper scripts in bin
    mkdir -p $out/bin
    makeWrapper $out/share/git-worktree-runner/bin/git-gtr $out/bin/git-gtr \
      --prefix PATH : ${lib.makeBinPath [ bash git coreutils ]}
    makeWrapper $out/share/git-worktree-runner/bin/gtr $out/bin/gtr \
      --prefix PATH : ${lib.makeBinPath [ bash git coreutils ]}

    # Install shell completions
    installShellCompletion --bash completions/gtr.bash
    installShellCompletion --fish completions/git-gtr.fish
    installShellCompletion --zsh completions/_git-gtr

    runHook postInstall
  '';

  meta = {
    description = "A portable, cross-platform CLI for managing git worktrees with ease";
    homepage = "https://github.com/coderabbitai/git-worktree-runner";
    license = lib.licenses.asl20;
    maintainers = [ ];
    platforms = lib.platforms.unix;
    mainProgram = "git-gtr";
  };
}
