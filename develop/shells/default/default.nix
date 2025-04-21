{
  inputs,
  pkgs,
  mkShell,
  system,
  ...
}:
let
  jdk = pkgs.graalvmPackages.graalvm-ce; # pkgs.jdk23;
  kotlin = pkgs.kotlin.override { jre = jdk; };
  gradle = pkgs.gradle.override { java = jdk; };
in
mkShell {
  packages = [
    jdk
    kotlin
    gradle
    # ant
  ];

  inherit (inputs.self.checks.${system}.pre-commit-check) shellHook;
  buildInputs = inputs.self.checks.${system}.pre-commit-check.enabledPackages;
}
