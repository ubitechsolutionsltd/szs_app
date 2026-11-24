#!/bin/bash
# Runs the app locally; it talks to the public API in lib/backend/api_requests/api_calls.dart
cd "$(dirname "$0")" || exit 1
export PATH="$PATH:$HOME/Desktop/Softwares/flutter/bin:$HOME/flutter/bin:$HOME/development/flutter/bin:/opt/homebrew/bin:/usr/local/bin:$HOME/.gem/ruby/2.6.0/bin"
export RUBYOPT="-rlogger"
if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter not found in PATH. Install it or edit PATH in this script."; read -n1 -p "Press any key..."; exit 1
fi
flutter pub get || { read -n1 -p "pub get failed. Press any key..."; exit 1; }
if ! flutter devices 2>/dev/null | grep -qiE "ios|android|emulator|simulator"; then
  flutter emulators --launch apple_ios_simulator >/dev/null 2>&1 && sleep 20
fi
if flutter devices 2>/dev/null | grep -qiE "ios|android"; then
  flutter run
else
  flutter run -d chrome
fi
read -n1 -p "Finished. Press any key..."
