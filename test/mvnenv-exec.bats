#!/usr/bin/env bats

setup() {
  export MVNENV_ROOT="$(mktemp -d)"
  export MVNENV_DIR="$(mktemp -d)"
}

teardown() {
  rm -rf "$MVNENV_ROOT"
  rm -rf "$MVNENV_DIR"
}

@test "given --complete when running mvnenv-exec then it exits" {
  export MVNENV_ROOT="$(mktemp -d)"

  run ./bin/mvnenv-exec --complete

  [ "$status" -eq 0 ]
}

@test "given no version configured when running mvnenv-exec then it fails with message" {
  run ./bin/mvnenv-exec dummy-command
  [ "$status" -ne 0 ]
}
