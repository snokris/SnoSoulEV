#!/usr/bin/env bash
set -euo pipefail

default_java_home="/opt/homebrew/opt/openjdk@17"
default_android_sdk="/opt/homebrew/share/android-commandlinetools"

java_home="${JAVA_HOME:-$default_java_home}"
android_sdk="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-$default_android_sdk}}"

if [[ ! -x "$java_home/bin/java" ]]; then
  echo "JDK 17 not found at $java_home" >&2
  echo "Install it with: brew install openjdk@17" >&2
  exit 1
fi

if [[ ! -d "$android_sdk/platforms/android-35" ]]; then
  echo "Android SDK 35 not found below $android_sdk" >&2
  echo "Install it with: sdkmanager 'platform-tools' 'platforms;android-35' 'build-tools;35.0.0'" >&2
  exit 1
fi

export JAVA_HOME="$java_home"
export ANDROID_HOME="$android_sdk"
export ANDROID_SDK_ROOT="$android_sdk"
export PATH="$JAVA_HOME/bin:$ANDROID_HOME/platform-tools:$PATH"

exec "$@"
