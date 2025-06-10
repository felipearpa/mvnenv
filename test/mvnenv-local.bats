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
  mkdir -p "$MVNENV_ROOT/versions"
  ln -s /some/path/to/maven "$MVNENV_ROOT/versions/$version_name"

  run ./bin/mvnenv-local "$version_name"

  [ "$status" -eq 0 ]
  [ -f .mvn-version ]
  [ "$(cat .mvn-version)" = "$version_name" ]

  rm -f "$MVNENV_ROOT/versions/$version_name"
  rm .mvn-version
}

@test "given local version exists when setting new version then it is overwritten" {
  mkdir -p "$MVNENV_ROOT/versions"
  echo "old-version" > .mvn-version

  ln -s /some/path "$MVNENV_ROOT/versions/old-version"
  ln -s /some/other/path "$MVNENV_ROOT/versions/new-version"

  run ./bin/mvnenv-local new-version

  [ "$status" -eq 0 ]
  [ "$(cat .mvn-version)" = "new-version" ]

  rm .mvn-version
  rm -f "$MVNENV_ROOT/versions/old-version"
  rm -f "$MVNENV_ROOT/versions/new-version"
}
