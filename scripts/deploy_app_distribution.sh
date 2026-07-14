#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# App configuration
PROJECT_ID="wirdul-latif-pro"
ANDROID_APP_ID="1:1069262636562:android:a89868fd82d8819898bacb"
IOS_APP_ID="1:1069262636562:ios:73a3685410e56fb098bacb"

# Colors for neat formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0;37m' # No Color

echo -e "${BLUE}=== Wirdul Latif Pro - Firebase App Distribution Deployer ===${NC}\n"

# 1. Pre-requisites Check
echo -e "${YELLOW}Checking pre-requisites...${NC}"

# Detect Flutter command (standard, home path, or Shorebird fallback)
if command -v flutter &> /dev/null; then
    FLUTTER_CMD="flutter"
elif [ -f "$HOME/flutter/bin/flutter" ]; then
    FLUTTER_CMD="$HOME/flutter/bin/flutter"
else
    # Try to locate the Flutter binary installed by Shorebird
    SHOREBIRD_FLUTTER=$(find "$HOME/.shorebird/bin/cache/flutter" -name "flutter" -type f 2>/dev/null | head -n 1)
    if [ -n "$SHOREBIRD_FLUTTER" ] && [ -f "$SHOREBIRD_FLUTTER" ]; then
        FLUTTER_CMD="$SHOREBIRD_FLUTTER"
    else
        echo -e "${RED}Error: Neither Flutter SDK nor Shorebird's internal Flutter was found.${NC}"
        exit 1
    fi
fi

if ! command -v firebase &> /dev/null; then
    echo -e "${RED}Error: Firebase CLI is not installed.${NC}"
    echo -e "Install it using: npm install -g firebase-tools"
    exit 1
fi

# Ensure user is logged into Firebase
echo -e "Verifying Firebase authentication status..."
if ! firebase projects:list &> /dev/null; then
    echo -e "${YELLOW}You are not logged into Firebase CLI. Starting firebase login...${NC}"
    firebase login
fi

echo -e "${GREEN}Pre-requisites satisfied!${NC}\n"

# 2. Select Platform
echo -e "Which platform(s) would you like to build and distribute?"
echo -e "1) Android (APK)"
echo -e "2) iOS (IPA)"
echo -e "3) Both"
read -p "Select option (1-3): " platform_choice

case $platform_choice in
    1) BUILD_ANDROID=true; BUILD_IOS=false ;;
    2) BUILD_ANDROID=false; BUILD_IOS=true ;;
    3) BUILD_ANDROID=true; BUILD_IOS=true ;;
    *) echo -e "${RED}Invalid choice. Exiting.${NC}"; exit 1 ;;
esac

# 3. Testers, Groups & Release Notes
read -p "Enter tester emails (comma-separated, default is 'aslahmoto@gmail.com'): " tester_emails
tester_emails=${tester_emails:-"aslahmoto@gmail.com"}

read -p "Enter tester groups (comma-separated, press Enter to skip): " tester_groups

read -p "Enter release notes for this build (optional): " release_notes
if [ -z "$release_notes" ]; then
    release_notes="Manual deployment on $(date)"
fi

echo -e "\n${BLUE}Configuration summary:${NC}"
echo -e "- Tester Emails: ${GREEN}$tester_emails${NC}"
echo -e "- Tester Groups: ${GREEN}${tester_groups:-None}${NC}"
echo -e "- Release Notes:  ${GREEN}$release_notes${NC}\n"

# Clean build directory before building
echo -e "${YELLOW}Cleaning Flutter build directory...${NC}"
$FLUTTER_CMD clean
$FLUTTER_CMD pub get

# 4. Deploy Android
if [ "$BUILD_ANDROID" = true ]; then
    echo -e "\n${BLUE}--- Processing Android build ---${NC}"
    echo -e "${YELLOW}Building Release APK...${NC}"
    $FLUTTER_CMD build apk --release

    APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
    if [ -f "$APK_PATH" ]; then
        echo -e "${GREEN}Android APK built successfully at $APK_PATH${NC}"
        echo -e "${YELLOW}Uploading to Firebase App Distribution...${NC}"
        
        # Build Firebase CLI distribution arguments
        DIST_ARGS=("$APK_PATH" --app "$ANDROID_APP_ID" --release-notes "$release_notes")
        if [ -n "$tester_emails" ]; then
            DIST_ARGS+=(--testers "$tester_emails")
        fi
        if [ -n "$tester_groups" ]; then
            DIST_ARGS+=(--groups "$tester_groups")
        fi
        
        firebase appdistribution:distribute "${DIST_ARGS[@]}"
        echo -e "${GREEN}Android deployment complete!${NC}"
    else
        echo -e "${RED}Error: APK file not found at $APK_PATH.${NC}"
        exit 1
    fi
fi

# 5. Deploy iOS
if [ "$BUILD_IOS" = true ]; then
    echo -e "\n${BLUE}--- Processing iOS build ---${NC}"
    echo -e "${YELLOW}Building Release IPA (Ad-Hoc)...${NC}"
    $FLUTTER_CMD build ipa --release --export-method=ad-hoc

    # Find the generated IPA in build/ios/ipa/
    IPA_PATH=$(find build/ios/ipa -name "*.ipa" -print -quit 2>/dev/null)

    if [ -n "$IPA_PATH" ] && [ -f "$IPA_PATH" ]; then
        echo -e "${GREEN}iOS IPA built successfully at $IPA_PATH${NC}"
        echo -e "${YELLOW}Uploading to Firebase App Distribution...${NC}"
        
        # Build Firebase CLI distribution arguments
        DIST_ARGS=("$IPA_PATH" --app "$IOS_APP_ID" --release-notes "$release_notes")
        if [ -n "$tester_emails" ]; then
            DIST_ARGS+=(--testers "$tester_emails")
        fi
        if [ -n "$tester_groups" ]; then
            DIST_ARGS+=(--groups "$tester_groups")
        fi
        
        firebase appdistribution:distribute "${DIST_ARGS[@]}"
        echo -e "${GREEN}iOS deployment complete!${NC}"
    else
        echo -e "${RED}Error: No IPA file found in build/ios/ipa/. Please make sure your iOS signing is configured correctly in Xcode.${NC}"
        exit 1
    fi
fi

echo -e "\n${GREEN}Deployment processes completed successfully!${NC}"
