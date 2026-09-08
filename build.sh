#!/usr/bin/env sh
set -eu
if ! command -v cedev-config >/dev/null 2>&1; then
  echo "CEdev/CE Toolchain is not on PATH." >&2
  echo "Install CE Toolchain v15.0+ and put its bin directory on PATH, then rerun ./build.sh" >&2
  exit 1
fi
make clean
make
printf '\nBuilt bin/CROLLER.8xp\n'
