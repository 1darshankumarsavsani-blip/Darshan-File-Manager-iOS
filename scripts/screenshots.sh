#!/bin/bash
# Best effort: boots an iPhone simulator, launches the app in demo mode and takes real simulator screenshots.
set -uo pipefail
cd "$(dirname "$0")/.."
OUT=build/screenshots; mkdir -p "$OUT"
APP="${BUILD_APP:-$(find build/Build/Products -name 'DarshanFileManager.app' -maxdepth 3 | head -1)}"
[ -d "$APP" ] || { echo "no app"; exit 0; }

DEVICE_NAME=$(xcrun simctl list devices available | grep -E "iPhone [0-9]+ Pro \(" | head -1 | sed -E 's/^ *(.*) \([0-9A-F-]{36}\).*/\1/')
UDID=$(xcrun simctl list devices available | grep -F "$DEVICE_NAME (" | head -1 | grep -oE "[0-9A-F-]{36}")
echo "Using $DEVICE_NAME $UDID"
xcrun simctl boot "$UDID" || true
xcrun simctl bootstatus "$UDID" -b || true
xcrun simctl install "$UDID" "$APP"

shot() {  # name tab theme accent lang
  xcrun simctl terminate "$UDID" com.darshancorp.filemanager >/dev/null 2>&1 || true
  xcrun simctl launch "$UDID" com.darshancorp.filemanager -demo YES -tab "$2" -theme "$3" -accent "$4" -lang "$5"
  sleep 6
  xcrun simctl io "$UDID" screenshot "$OUT/$1.png"
}
shot ios_sort_light 0 light maroon en
shot ios_sort_dark 0 dark maroon en
shot ios_duplicates_light 1 light maroon en
shot ios_old_dark 2 dark blue en
shot ios_rename_light 3 light green en
shot ios_rules_dark 4 dark maroon en
shot ios_storage_light 5 light gold en
shot ios_settings_dark 6 dark purple en
shot ios_settings_gujarati_light 6 light maroon gu
shot ios_sort_gujarati_dark 0 dark orange gu
ls -l "$OUT"
