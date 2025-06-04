#!/usr/bin/env bats

setup() {
  export MVNENV_ROOT="$(mktemp -d)"
  export PATH="$MVNENV_ROOT:$PATH"

  export MVNENV_DIR="$(mktemp -d)"
}

teardown() {
  rm -rf "$MVNENV_ROOT"
  rm -rf "$MVNENV_DIR"
}

@test "given --complete when running mvnenv-local then it runs mvnenv versions via exec" {
  export MVNENV_ROOT="$(mktemp -d)"
  export PATH="$MVNENV_ROOT:$PATH"

  echo -e '#!/bin/bash\necho "stub-version-output"' > "$MVNENV_ROOT/mvnenv"
  chmod +x "$MVNENV_ROOT/mvnenv"

  run ./bin/mvnenv-local --complete
  [ "$status" -eq 0 ]
  [[ "$output" == *"--unset"* ]]
  [[ "$output" == *"options"* ]]
  [[ "$output" == *"stub-version-output"* ]]
}

@test "given local version file when running mvnenv-local then it prints only the version value" {
  local version_name="apache-maven-3.9.6"
  echo "$version_name" > .mvn-version

  run ./bin/mvnenv-local

  [ "$status" -eq 0 ]
  [[ "$output" == *"$version_name"* ]]

  rm .mvn-version
}

@test "given no local version when running mvnenv-local then it exits with error" {
  rm -f .mvn-version  # Asegura que no exista

  run ./bin/mvnenv-local

  [ "$status" -ne 0 ]
}

@test "given unknown version name when running mvnenv-local then it fails" {
  local fake_version="not-installed-version"

  run ./bin/mvnenv-local "$fake_version"

  [ "$status" -ne 0 ]
}

@test "given installed Maven version when running mvnenv-local then it sets the local version" {
  local version_name="apache-maven-3.9.6"
  mkdir -p "$MVNENV_DIR/versions"
  ln -s /some/path/to/maven "$MVNENV_DIR/versions/$version_name"

  run ./bin/mvnenv-local "$version_name"

  [ "$status" -eq 0 ]
  [ -f .mvn-version ]
  [ "$(cat .mvn-version)" = "$version_name" ]

  rm .mvn-version
}
