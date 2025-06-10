#!/usr/bin/env bats

setup() {
  REPO_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
}

teardown() {
  cd "$REPO_DIR"
}

given_git_repo() {
  tmp_git_repo="$(mktemp -d)"
  cd "$tmp_git_repo"
  trap "rm -rf \"$tmp_git_repo\"" EXIT

  git init -q
  real_tmp_git_repo="$(cd "$tmp_git_repo" && pwd -P)"
}

given_git_repo_in_child_folder() {
  tmp_git_repo="$(mktemp -d)"
  cd "$tmp_git_repo"
  trap "rm -rf \"$tmp_git_repo\"" EXIT

  git init -q
  real_tmp_git_repo="$(cd "$tmp_git_repo" && pwd -P)"

  mkdir -p subdir/childdir
  cd subdir/childdir
}

given_no_git_repo() {
  tmp_dir="$(mktemp -d)"
  cd "$tmp_dir"
  trap "rm -rf \"$tmp_dir\"" EXIT
}

when_running_mvnenv_root_dir() {
  run "$REPO_DIR/bin/mvnenv-root-dir"
}

then_returns_repo_root() {
  [ "$status" -eq 0 ]
  [ "$output" = "$real_tmp_git_repo" ]
}

then_returns_dot() {
  [ "$status" -eq 0 ]
  [ "$output" = "." ]
}

@test "given git repo when running mvnenv-root-dir then it returns the repo root" {
  given_git_repo
  when_running_mvnenv_root_dir
  then_returns_repo_root
}

@test "given git repo when running mvnenv-root-dir from child folder then it returns the repo root" {
  given_git_repo_in_child_folder
  when_running_mvnenv_root_dir
  then_returns_repo_root
}

@test "given no git repo when running mvnenv-root-dir then it returns dot" {
  given_no_git_repo
  when_running_mvnenv_root_dir
  then_returns_dot
}
