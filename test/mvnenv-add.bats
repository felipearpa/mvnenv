#!/usr/bin/env bats

setup() {
  export MVNENV_ROOT="$(mktemp -d)"
  export DUMMY_MAVEN_DIR="$(mktemp -d)"
}

teardown() {
  rm -rf "$MVNENV_ROOT"
  rm -rf "$DUMMY_MAVEN_DIR"
}

@test "given non-existent path when running mvnenv-add then it fails" {
  non_existing_path="/non/existing/maven"
  run ./bin/mvnenv-add "$non_existing_path"
  [ "$status" -ne 0 ]
}

@test "given existing path when running mvnenv-add then it creates a symlink" {
  version_name="$(basename "$DUMMY_MAVEN_DIR")"
  run ./bin/mvnenv-add "$DUMMY_MAVEN_DIR"
  [ "$status" -eq 0 ]
  [ -L "$MVNENV_ROOT/versions/$version_name" ]
  [ "$(readlink "$MVNENV_ROOT/versions/$version_name")" = "$DUMMY_MAVEN_DIR" ]
}
