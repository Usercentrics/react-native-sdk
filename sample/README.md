# Usercentrics React Native SDK — Sample App

This is the reference sample application for the [Usercentrics React Native SDK](https://github.com/Usercentrics/react-native-sdk). It demonstrates the full SDK integration across the predefined UI, custom UI, webview session handoff, GPP, and consent mediation with Firebase Analytics.

## Prerequisites

Before running the sample app, ensure your environment meets the following requirements.

### All Platforms
- **Node.js 18.0+** (LTS recommended)
- **npm 9.0+** or **Yarn 1.22+**
- **React Native 0.74.3+**
- **Watchman** (recommended for file watching)

### Android
- **Java 17+** (OpenJDK or Oracle JDK)
- **Android SDK** with API 34+ platforms installed
- **Android NDK 25+**
- **Gradle 8.2+**
- A running Android Emulator (AVD) or a connected physical device

### iOS (macOS only)
- **Xcode 15.0+**
- **CocoaPods 1.12+**
- An iOS Simulator or connected physical device

---

## Project Structure

```
sample/
├── src/
│   ├── App.tsx                          # SDK initialisation and navigation root
│   └── screens/
│       ├── Home.tsx                     # Main consent flow (auto status check, first/second layer)
│       ├── CustomUI.tsx                 # Programmatic API demo (GDPR / TCF / CCPA)
│       ├── WebviewIntegrationScreen.tsx # In-App SDK → Browser SDK session handoff
│       └── GppTestingScreen.tsx         # GPP string and section-change event testing
├── android/                             # Android project (Kotlin, Firebase integrated)
│   ├── app/
│   │   ├── build.gradle.kts            # Firebase BOM, google-services plugin
│   │   └── src/main/AndroidManifest.xml# Firebase collection flags (all false by default)
│   └── build.gradle.kts               # google-services classpath
└── ios/                                 # iOS project (Swift, Firebase integrated)
    ├── Podfile                          # FirebaseAnalytics pod
    └── sample/
        ├── AppDelegate.swift            # FirebaseApp.configure() call
        ├── Info.plist                   # FIREBASE_ANALYTICS_COLLECTION_ENABLED = false
        └── PrivacyInfo.xcprivacy        # NSUserDefaults access reasons for Firebase
```

---

## SDK Initialisation

The SDK is initialised once on app start in `src/App.tsx`:

```tsx
// Set to true when testing consent mediation. Keep false for normal builds.
const MEDIATION_TEST_ENABLED = true;
const SETTINGS_ID = '3C9-yvno8-dEzy';

React.useEffect(() => {
    Usercentrics.configure({
        settingsId: SETTINGS_ID,
        loggerLevel: UsercentricsLoggerLevel.debug,
        consentMediation: MEDIATION_TEST_ENABLED,
    });
}, []);
```

`MEDIATION_TEST_ENABLED` and `SETTINGS_ID` are the single place to control mediation mode and the target Usercentrics configuration. No other files need to change — toggle the flag and rebuild.

---

## Running the Sample App

### Step 1 — Install Dependencies

From the **repo root**:

```sh
npm install --legacy-peer-deps
```

Then from the **`sample/` folder**:

```sh
npm install --legacy-peer-deps
```

### Step 2 — Run on Android

Ensure a running emulator or connected device is available, then from the `sample/` folder:

```sh
npm run android
# or
npx react-native run-android
```

To list available AVDs and launch one:

```sh
emulator -list-avds
emulator -avd <avd-name>
```

> **Port conflict:** If Metro is already running on port 8081, stop it first (`kill $(lsof -t -i:8081)`) or run `npm run fix-metro` to clear it.

### Step 3 — Run on iOS (macOS only)

Install CocoaPods dependencies from the `sample/` folder:

```sh
npx pod-install
```

> Re-run `npx pod-install` any time you change `ios/Podfile` or pull changes that modify native dependencies.

Then run the app:

```sh
npm run ios
# or
npx react-native run-ios
```

To target a specific simulator:

```sh
npx react-native run-ios --simulator "iPhone 15 Pro"
```

List available simulators:

```sh
xcrun simctl list devices available
```

### Step 4 — Start Metro Manually (optional)

`react-native run-android` / `run-ios` auto-start Metro. If you need to start it separately:

```sh
npm start
```

---

## Screen Guide

### Home Screen

Entry point of the consent flow. On launch it calls `Usercentrics.status()` automatically:

- If `shouldCollectConsent` is `true` → the first-layer banner is shown immediately
- Otherwise → existing consents are applied via `applyConsent()`

Buttons available:

| Button | Action |
|--------|--------|
| Show First Layer | Opens the predefined consent banner |
| Show Second Layer | Opens the detailed consent preferences screen |
| Customization Example 1 / 2 | Opens the first layer with custom `BannerSettings` |
| Custom UI | Navigates to the Custom UI screen |
| Webview Integration | Navigates to the Webview Integration screen |
| GPP Testing | Navigates to the GPP Testing screen |

### Custom UI Screen

Demonstrates the programmatic SDK API for building a fully custom consent UI. Adapts to the active legal framework:

| Framework | APIs exercised |
|-----------|---------------|
| GDPR (default) | `getCMPData`, `acceptAll`, `denyAll`, `saveDecisions`, `getConsents`, `changeLanguage` |
| TCF | `getCMPData`, `getTCFData`, `setCMPId`, `acceptAllForTCF`, `denyAllForTCF`, `saveDecisionsForTCF` |
| CCPA | `getCMPData`, `saveOptOutForCCPA` |

All consent outputs are logged to the console. Open Logcat (Android) or the Xcode console (iOS) to inspect them.

### Webview Integration Screen

Demonstrates passing the native consent session to a WebView so the Browser SDK can inherit it without re-asking for consent. It:

1. Calls `Usercentrics.getUserSessionData()` to retrieve the encoded session token
2. Injects it into the WebView as `window.UC_UI_USER_SESSION_DATA` before page load
3. The Browser SDK loaded in the WebView reads this value and skips the consent banner

### GPP Testing Screen

Exercises the Global Privacy Platform (GPP) API:

| Action | API |
|--------|-----|
| Read the current GPP string | `Usercentrics.getGPPString()` |
| Read full GPP data as JSON | `Usercentrics.getGPPData()` |
| Write a consent signal | `Usercentrics.setGPPConsent('usnat', 'SaleOptOut', 2)` |
| Listen to section changes | `Usercentrics.onGppSectionChange(callback)` |

Section-change events are displayed in real time on screen.

---

## Consent Mediation

Consent Mediation lets the Usercentrics SDK automatically propagate user consent decisions to third-party SDKs — no manual wiring required in your app code.

### How It Works

When `consentMediation: true` is passed to `Usercentrics.configure()`, the SDK intercepts consent decisions and forwards them to every registered mediation partner at the correct point in the consent lifecycle.

### Enabling / Disabling Mediation

Open `src/App.tsx` and toggle the constant at the top:

```tsx
// true  → SDK automatically propagates consent to Firebase and other partners
// false → standard mode, no automatic propagation
const MEDIATION_TEST_ENABLED = true;
```

Rebuild and relaunch after changing the value.

### Firebase Analytics Integration

Firebase Analytics is included as a reference mediation partner. It is configured to collect **no data** until Usercentrics grants consent.

**Android setup**
- `com.google.gms:google-services:4.4.2` classpath in `android/build.gradle.kts`
- `com.google.gms.google-services` plugin in `android/app/build.gradle.kts`
- Firebase BOM `33.13.0` + `firebase-analytics` in `android/app/build.gradle.kts`
- All collection flags default to `false` in `AndroidManifest.xml`:

```xml
<meta-data android:name="firebase_analytics_collection_enabled" android:value="false" />
<meta-data android:name="google_analytics_default_allow_analytics_storage" android:value="false" />
<meta-data android:name="google_analytics_default_allow_ad_storage" android:value="false" />
<meta-data android:name="google_analytics_default_allow_ad_user_data" android:value="false" />
<meta-data android:name="google_analytics_default_allow_ad_personalization_signals" android:value="false" />
```

**iOS setup**
- `pod 'FirebaseAnalytics'` in `ios/Podfile`
- `FirebaseApp.configure()` at the top of `application(_:didFinishLaunchingWithOptions:)` in `AppDelegate.swift`
- `FIREBASE_ANALYTICS_COLLECTION_ENABLED` set to `false` in `ios/sample/Info.plist`
- `PrivacyInfo.xcprivacy` updated with the NSUserDefaults access reasons required by Firebase

### Firebase Config Files

Firebase requires platform-specific config files that contain project credentials. These files are **not stored in this repository** and must be added manually before building.

| Platform | File | Location |
|----------|------|----------|
| Android | `google-services.json` | `sample/android/app/` |
| iOS | `GoogleService-Info.plist` | `sample/ios/sample/` |

**Steps to add the files:**

1. Obtain the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) from the Firebase Console for the Firebase project used with this sample app.
2. Place each file in the path shown in the table above.
3. For iOS: the Xcode project already has `GoogleService-Info.plist` wired as a build resource in `project.pbxproj` — no Xcode changes needed.
4. For Android: the `google-services` Gradle plugin is already configured in `android/build.gradle.kts` and `android/app/build.gradle.kts` — no Gradle changes needed.
5. Build and run the app as described in [Running the Sample App](#running-the-sample-app).

> Both files are listed in `.gitignore` and will not be accidentally committed.

### Testing Mediation Step by Step

1. Set `MEDIATION_TEST_ENABLED = true` in `src/App.tsx`
2. Place the Firebase config files in the correct locations (see above)
3. Build and run the app on a device or simulator
4. On first launch the consent banner appears automatically — accept or deny
5. Check the logs to confirm Firebase received the correct consent signal:
   - **Android**: Logcat → filter by `Firebase` or `Usercentrics`
   - **iOS**: Xcode console → filter by `Firebase` or `Usercentrics`
6. To re-test: clear app data (Android) or reinstall the app (iOS) to reset consent state, then relaunch

For full documentation see the [Usercentrics Consent Mediation guide](https://usercentrics.com/docs/apps/features/consent-mediation/#enable-mediation).

---

## New Architecture

The sample app runs with **React Native New Architecture (Fabric + TurboModules) enabled by default**.

To toggle it, change the following two files and ensure they match:

**`ios/Podfile`**
```ruby
$RCT_NEW_ARCH_ENABLED = true  # set to false for Legacy Architecture
```

**`android/gradle.properties`**
```properties
newArchEnabled=true  # set to false for Legacy Architecture
```

After changing the iOS flag, run `npx pod-install` from the `sample/` folder before rebuilding.

---

## Available Scripts

| Script | Description |
|--------|-------------|
| `npm run android` | Run the Android app |
| `npm run ios` | Run the iOS app |
| `npm start` | Start the Metro bundler |
| `npm run android-build` | Assemble a debug APK via Gradle |
| `npm run clean-and-build` | Clean all caches and rebuild |
| `npm run clean-all-caches` | Clean project and system caches |
| `npm run fix-sandbox` | Fix Xcode sandbox permission issues |
| `npm run fix-metro` | Kill stale Metro processes and clear the Metro cache |
| `npm run build-ios` | Run the iOS build validation script |
| `npm test` | Run unit tests |
| `npm run lint` | Run ESLint |

---

## Troubleshooting

**Metro port conflict**
```sh
npm run fix-metro
# or manually:
kill $(lsof -t -i:8081)
```

**iOS pod issues**
```sh
npx pod-install
```
Re-run after any Podfile change or native dependency update.

**Android emulator not found**
```sh
emulator -list-avds          # list available AVDs
emulator -avd <avd-name>     # start one before running the app
```

**Full clean and reinstall**
```sh
npm run clean-all-caches
npm install --legacy-peer-deps
npx pod-install              # iOS only
```

**General React Native issues**
See the [React Native Troubleshooting guide](https://reactnative.dev/docs/troubleshooting).
