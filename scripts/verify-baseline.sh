#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$(cd "$script_dir/.." && pwd)"

cd "$project_dir"

before_version="$(git hash-object app/version.properties)"

"$script_dir/android-env.sh" ./gradlew --no-daemon \
  testDebugUnitTest \
  assembleDebug \
  assembleDebugAndroidTest \
  lintDebug

after_version="$(git hash-object app/version.properties)"
if [[ "$before_version" != "$after_version" ]]; then
  echo "ERROR: the build modified app/version.properties" >&2
  exit 1
fi

echo "Baseline verification completed without modifying app/version.properties."
