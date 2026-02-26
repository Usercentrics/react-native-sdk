[Release Notes](https://docs.usercentrics.com/cmp_in_app_sdk/latest/about/history/)
### 2.25.0 – Feb 23, 2026
## Improvement
* Added `specialPurposes` and `optOut` fields to TCF vendor disclosures for detailed storage information
* Added SDKs section in the second layer UI with name and usage

### 2.24.4 – Jan 27, 2026
## Improvement
* Added a new feature allowing admins to show or hide the "Manage Settings" button
* Added TCF Storage Disclosures and detailed storage information views for CTV.
* Updated logic to ensure unsaved Legitimate Interest settings are correctly captured even after a user clicks "Deny All.
* Added status text for Legitimate Interest (LI) toggles on Android TV and AppleTV to clearly show if they are enabled/disabled
* UI improvements and fixes

### 2.24.3 – Dec 18, 2025
## Improvement
* Updated CTV first layer CMP to fully align with TCF requirements by displaying purposes and stacks based on the Admin UI configuration, matching web and mobile behavior.
* Added proper labels for Consent and Legitimate Interest toggles in the CTV second layer, resolving TCF policy check 23.
* Introduced vendor storage information section (cookies and non-cookie access details) in the CTV second layer, addressing TCF policy check 24.
* Changes apply to both Android and iOS CTV implementations.

### 2.24.2 – Dec 5, 2025
## Improvement
* Fix react native issues

### 2.24.1 – Oct 31, 2025
## Improvement
* TCF 2.3 Support: Support the latest Transparency & Consent Framework 2.3.
* TCF 2.3 Support: fixes about tcString
* Special Features Section: Added support for the new Special Features/Purposes section.
* Fix issue where the SDK failed to initialize offline.

### 2.24.0 – Oct 31, 2025
## React Native
* Added Fabric renderer compatibility

### 2.23.3 – Oct 6, 2025
## React Native
* Updated React Native to 0.79.6 to support 16 KB page sizes
* Fix react native issues 

### 2.23.2 – Oct 1, 2025
## React Native
* Updated React Native to 0.79.6 to support 16 KB page sizes

### 2.23.0 - Sep 15, 2025
## Android/iOS Bug Fixes:
* Fixed bugs related to Google Consent Strings on DenyAll, ensuring correct consent handling
* Resolved geolocation issue reported in version 2.22.2
* Fixed accessibility contrast issues for improved usability

### 2.22.2 - Aug 7, 2025
## Feature - Consent Mediation
* Added support for AirBridge SDK
* Add GDPR API AcceptAll / DenyAll / SaveDecisions for Unity
* Fixed dependency download issue in versions 2.22.0 and 2.22.1.
* Added missing Proguard rules for Airbridge in versions 2.22.0 and 2.22.1.
## Android/iOS Bug Fixes:
* Improvements to geolocation handling
* Adjustments to DAU tracking logic

### 2.21.1 - Jul 25, 2025
## Improvement
## Android/iOS Bug Fixes:
* Fixed crashes related to the UI

### 2.21.0 - Jun 18, 2025
## Feature - Consent Mediation
* Added support for AppsFlyer SDK
* Added support for Singular SDK
## Improvement - Exposing `category` field in `UsercentricsServiceConsent` object
## iOS Bug Fixes:
* Accessibility improvements with VoiceOver and keyboard focus
* Fixed button sizes when expanding font size

### 2.20.3 - May 30, 2025
## Improvement: Accessibility Enhancements
* iOS: Enhanced VoiceOver support when expanding cards across all compliance frameworks.

### 2.20.2 - May 27, 2025
## Improvement: Accessibility Enhancements
* Android & iOS: Implemented general accessibility improvements, including better color contrast, adjustments to touch target sizes, improved focus order, and fixes to prevent keyboard traps enhancing compatibility with assistive technologies and overall usability.

### 2.20.1 - May 7, 2025
## Improvements: Accessibility Enhancements - Enhanced accessibility features to provide a more inclusive user experience.
* Android Bug Fixes:
  * Ensured minimum touch target size of 24dp for interactive elements.
  * Added status messages to announce additional content for screen readers.
* iOS Bug Fixes:
  * Added status messages to announce additional content for screen readers.
  * Fixed dynamic type behavior to correctly resize text when accessibility text size is increased.

### 2.20.0 - April 16, 2025
## Feature
* TCF Updates - TCF library updated to version 1.5.15 to resolve LI signaling ambiguity for vendors with Purposes under consent and Special Purposes
  * Implemented LI signalling to vendors only registered for Special Purposes with TCF Technical specifications
  * Added support for new languages: Albanian (SQ), Chinese Traditional (ZH-HANT), Georgian (KA), Hindi (HI), Thai (TH), Vietnamese (VI)

### 2.19.0 - March 24, 2025

## Improvements
* Resolved an SDK cache issue that was causing the banner to display an inconsistent UI.
* Accessibility features for a better user experience.

### 2.18.9 - February 27, 2025

## Fixes
* Apple TV issue where focus would be lost when a cell contained a long description label.
* Restore User Session issue where resurfacing did not occur when switching sessions between users.

### 2.18.6 - February 05, 2025

## Fixes
* An error occurring when trying to migrate from version 7 to 8.
* Issue causing SDK initialization to fail when using a specific version with Google's ATPs disabled.

## Improvements
* iOS - Enhanced accessibility by increasing the contrast of the focus indicator.
* Flutter - Exposing the stack trace when SDK initialization fails.

### 2.18.5 - January 23, 2025

## Fixes
* Issue causing a temporary unstable SDK state when calling the `clearUserSession()` API

## Android Bug Fixes
* Memory leak that occurred when displaying the banner's First Layer

## iOS Bug Fixes
* Accessibility by addressing instances where multiple links had identical link text

### 2.18.4 - January 07, 2025

## Android Bug Fixes

* Inconsistencies when showing the banner using the `windowFullscreen` parameter

## Fixes

* Google Consent Mode edge case when setting `analytics_storage` flag
* Clear User Session edge case when using caching certain requests

### 2.18.3 - December 11, 2024

## Features
* Removed support for Adjust version 4.

## Improvements
* Flutter: Exposed `legalBasis` field in `UsercentricsCMPData` class.

## Android Bug Fixes:
* Full-screen mode was not properly applied on certain devices, causing the banner to be displayed within the safe area.
* Banner content was hidden by the selfie camera when full-screen mode was activated.

### 2.18.2 - November 27, 2024

## Features
* Added support for manual resurface in the mobile SDK, which can be trigged through Admin Interface.

## Improvements
* Exposed `readLess` label in `UsercentricsLabels` object

### 2.18.1 - November 20, 2024

## Improvements
* Caching solutions - Improved our cache solution to provide faster initializations and better UX

### 2.18.0 - November 14, 2024

## Fixes
* [Fix] Crash when attempting to restore user session with controller id that only has TCF component

## Android Bug Fix:
* [Fix] Fixed issues related to dismissing banners in inactive activities.

### 2.17.3 - October 17, 2024

## Features
* Added support for right-to-left (RTL) languages in our SDK for enhanced localization and global accessibility.

## Fixes
* General fixes and performance improvements

### 2.17.2 - October 1, 2024

## Improvements
* Update to improve compatibility and ensure smoother performance with Google Consent Mode

### 2.17.1 - September 25, 2024

## Improvements
* Update to improve compatibility and ensure smoother performance with Google Consent Mode

### 2.17.0 - September 18, 2024

## Improvements
* TCF V5 - Updated to new TCF Policy version
  * Updated TCF banner second's layer to reflect the latest addition of Special Purpose 3
  * Updated TCF banner second's layer to include information related to the CMP’s maximum device storage duration
* Adjust Consent Mediation
  * Adding support for new Adjust version 5
  * Adjust version 4 will be supported until October 31, 2024
## iOS Bug Fixes
* ironSource Consent Mediation for CCPA not being applied
* HTML text not being rendered correctly

### 2.16.0 - September 4, 2024

## Features

* New timeout mode - In this version, you are able to customize the global timeout for the maximum amount of time that the SDK should take to fully initialize, just set the new parameter on the [UsercentricsOptions](https://usercentrics.com/docs/apps/api/core-api/#usercentricsoptions)

### 2.15.6 - August 14, 2024

## Other Fixes

* Toggle visibility of Deny Button on Second Layer for TVs
* Stability improvements when initializing the SDK

### 2.15.5 - July 31, 2024

## Improvements

* Google Consent Mode: Enhanced implementation when integrating with the TCF framework
* Deprecating `copy` field from `UsercentricsLabels`

## Other Fixes

* Crash when invoking `showSecondLayer(...)` method without arguments
* Adding missing labels in `UsercentrisLabels` object

### 2.15.4 - July 17, 2024

## Other Fixes

* Rare crash when initializing the SDK with TCF configuration
* Unity Ads SDK Mediation adjusts

### 2.15.3 - June 24, 2024

## React Native Bug Fix

**[Fix]** Services categories description was returning a stringify object instead of the actual description

### 2.15.2 - June 12, 2024

## Improvements

* Firebase Consent Mediation: Improved integration with its flags

## Android Bug Fix

* Fixed issues related to displaying banners in inactive activities

## Other Fixes

* Addressed sporadic crashes during TCF banner initializations on iOS.
* Enhanced code efficiency for smoother consent banner displays.

### 2.15.1 - May 29, 2024

## Improvements

* Consent mediation - Specific implementation for [Firebase Analytics and Advertising](https://usercentrics.com/docs/apps/features/google-consent-mode/) SDK
* Reset method deprecated for the SDK, React Native, Flutter and Unity
* Added support for new TCF languages
* Change TCF resurface period: from 13 months to 390 days

## iOS Bug Fixes

* UI improvement

## General Fixes

* Some DPSs had the cookie storage wrongly displayed

### 2.15.0 - April 25, 2024

## Improvements

* Upgrade to latest Kotlin version 1.9.23
* Officially changed Android SDK minimum version to API 21
* Releasing iOS SDKs that supports manual linkage
* General improvements on Google Consent Mode
* Apple Privacy Manifest** - Added new requirements to support new compliance rules, check them out [here](http://usercentrics.com/docs/apps/help/privacy_manifest/)

## iOS Bug Fixes

* Crashes on Xcode 15.2 when using new Apple's libraries linkage mechanism
* IronSource Consent Mediation integration tweaks to support their latest release

## Other Fixes

* Links not supported on banner message customizations were being displayed
* Controller ID card were not visible in certain conditions when Google Additional Providers were not present
* GDPR Banner was reappearing after a very specific scenario that changed the rule if it should be resurfaced or not

### 2.14.2 - April 10, 2024

## Improvements

* **Supports Read More on Banner Message** - Adds support to have a "read more" button on banner message displayed on the First Layer

## iOS Bug Fixes

* Sporadically crashes on `getUserSessionData` API

## Android Bug Fixes

* Sporadically crashes on TCF banner initializations

## Other Fixes

* Stability improvements

### 2.14.0 - April 4, 2024

## Features

* **Resurface Banner for Additional Tech Providers** - When changing Additional Tech Providers from Google, we are now enabling an option on Admin Interface to choose whether this should cause the banner to resurface or not

## Improvements

* Documentation about Consent Mediation on Flutter and React Native
* Support for Android Gradle Plugin 8 for Flutter
* Reset API will be deprecated in future versions

## iOS Bug Fixes

* UI improvements on spacing between labels

### 2.13.2 - March 13, 2024

## Features

**Clear User Session** - Introducing a new API designed to simplify the process of clearing user sessions

## Improvements

**Google Consent Mode Granular Choices** - Enhances integration with Google SDKs by updating to the latest changes.

**Adjust Granular Consent** - By Using Consent Mediation, we have fully integrated with Adjust SDK updates associated with the DMA

## iOS Bug Fixes

**[Fix]** Adjusts in landscape mode where labels were not fully aligned with other elements of the screen
**[tvOS Fix]** Numerous layout modifications have been made to address the arrangement of titles and the rendering of other elements in languages that result in larger text sizes

## Other Fixes

**[Fix]** Removes deprecated field TCFVendor::deviceStorage
**[Fix]** In certain scenarios, the 'Save Settings' button color was not customizable

### 2.13.0 - February 29, 2024

## Features

**New Usercentrics Ready API** - The API's new properties introduce a feature that, through Rulesets, allows identification of scenarios where the banner may be bypassed in specific locations, [check it out](integration/initialize.md#initialize-usercentrics)

## Improvements

**Removes TCF 2.0 warnings** - Since TCF 2.0 has been deprecated, we've removed all warnings regarding the usage of version 2.0 of this framework
**New TCF 2.2 Stacks** - Added support for Stacks 44 and 45

## Android Bug Fixes

**[Warning]** ⚠️Support for versions lower than Android 5.0 (API Level 20) is planned to be removed in releases starting from end of March/24
**[Fix]** Fully removes support for TLS 1.2 in Android versions lower than 5.0 (API Level 20)

## iOS Bug Fixes

**[Fix]** Banner was not correctly rendered given some specific programmatic customization scenarios
**[Fix]** Fixes layout constraints when changing the language for CCPA banners

## Other Fixes

**[Fix]** General improvement on resurfacing logic for any Legal Basis change on TCF Purposes

### 2.12.0 - February 15, 2024

## Features

* Consent choice persistence** - Prevents repeated banner displays across geographies for users moving across different legal frameworks (i.e. in case of frequent
  travellers)

## Improvements

* Displaying the count of third-party vendors by category title

## Android Bug Fixes

* Removes JVM Target ('1.8') compatibility annotation
* Improved UX on language selector popup

## iOS Bug Fixes

* Enhancing the UI of First-layer Popups and Sheets for Optimal Display on iPads

## Other Fixes

* Aligned purposes descriptions/illustrations and vendor data with GVL translation
* Edge case when certain services, hidden by their respective categories, were visible"
* Minor issues on session restoration when using TCF

### 2.11.3 - January 25, 2024

## Improvements

* Adds AC String into Updated Consent Event API

## Other Fixes

* Ensures accurate and proper display of large links on the Banner First and Second layer
* Deprecates deviceStorage field on TCF Vendor class

### 2.11.1 - January 10, 2024

## Improvements

* Rework of session restore checks to prevent empty/bogus Controller ID

## Android Bug Fixes

* Controller ID card replaced at the bottom when using Google Additional Consent
* Language selection menu will respect programmatic customization parameters
* Warning for Chartboost SDK when R8 is enabled
* Minor UI glitch where tab names were truncated when displaying the second layer in landscape mode

## iOS Bug Fixes

* Prevent fatal exceptions for a known iOS issue, more details [here](https://developer.apple.com/forums/thread/115405)

## Other Fixes

* Solved for Webview continuity previously not restoring consents to Google Additional Technology Providers
* Solves the problem where the option 'Show non-IAB purposes only for EU users' incorrectly impacts users from specific regions
* Application of consents when configuring the CMP to 'Do Not Display' with Geolocation Rules

### 2.11.0 - December 22, 2023

## Features

* Google Consent Mode V2 Support - Seamlessly integrate with the latest Google Consent Mode, ensuring enhanced privacy compliance and meeting Google requirements.
* Google Additional Consent Mode V2 - Integrate with the latest Google Additional Consent, allowing you to collect and signal additional consent for ad tech providers not covered by the IAB TCF V2.2.
* Display Number of Vendors for Each Purpose on TCF - Easily view the number of vendors associated with each purpose in the Transparency and Consent Framework.
* Chartboost SDK in Consent Mediation - Optimize revenue by effortlessly managing the Chartboost SDK within Usercentrics Consent Mediation.

## Improvements

* TCFUserDecisions API update - All properties have been changed from variables to constants. The adTechProviders field has been added which represent consents for Google Additional Consent Mode. On iOS this is a required argument, so if this is irrelevant for your configuration, just set an empty list, when needed.
* Location is only cached by the SDK for offline mode.

## Android Resolved Issues

* Avoid fetching any image resource after the banner has been closed.

## iOS Resolved Issues

* Prevent Long Privacy Legal Links from Being Truncated.
* Enable Scaled Fonts resources when using Custom UI.

## Other Resolved Issues

* Third-Party Vendors Count misalignment in some configurations.
* Fix the bug causing the banner to reappear for users outside the European Union, despite configurations being specifically set to enforce GDPR compliance exclusively for EU users.
* Update Link to Report Issues on Zendesk.

### 2.10.0 - November 16, 2023

## Improvements

* Accessibility: Various issues have been addressed to enhance accessibility.
  * Resolved banner compatibility issues with iOS VoiceOver.
  * Resolved banner compatibility issues with Android TalkBack.
  * Adjusted font sizes to comply with Accessibility requirements on both iOS and Android.

* Added Ukrainian support language for TCF.

## Resolved Issues

* Fixed the issue of not disclosing the setting "showCloseButton" has been addressed, preventing errors on Android.
* Fixed the crash on Android when passing an invalid controller id to restore the user session.
* Fixed The issue of the remote variant configuration not being used in first layer on Unity.

### 2.9.0 - October 6, 2023

## Features

* :rocket: **Full TCF 2.2 Support**: As the industry shifts to TCF 2.2 (deadline: November 20, 2024), we are pleased to announce that SDK Version 2.9.0 now offers comprehensive support for this new industry standard.
* :warning: **Important Note**: Please be aware that this version is incompatible with TCF 2.0. Before upgrading to V 2.9.0, ensure a smooth transition to TCF 2.2 following the  guidelines:

[How to migrate from TCF v2.0 to TCF v2.2](https://usercentrics.atlassian.net/wiki/spaces/SKB/pages/2668789801/How+to+migrate+from+TCF+v2.0+to+TCF+v2.2#\uD83D\uDCD8-Migration-instructions-for-TCF-v2.2)

## Key Changes and Enhancements:

* Updated Global Vendor List: We've transitioned to Global Vendor List v3 to align with industry standards.
* Legitimate Interest: To enhance transparency and privacy, purposes 3 to 6 have been removed, and purpose 11 has been introduced.
* Improved User Interface: We've made enhancements to the banner's second layer for a better user experience.
* Vendor Count Display: Users can now easily see the total count of IAB and non-IAB vendors.
* New Resurface Requirements: We've implemented new resurfacing requirements to keep your CMP compliant with the latest standards.

### 2.8.4 - September 27, 2023

## Improvements

* TCF performance is now improved for settings with a huge amount of vendors

## Resolved Issues

* UI small issues
* Solved general issues

### 2.8.3 - September 4, 2023

## Resolved Issues

* UI small issues on iOS (labels being cut, when they have long values)
* Fixed Deprecated DPS being shown
* Solved general issues

### 2.8.2 - July 12, 2023

## Features

* [Unity] New GetCmpData API, check out the documentation [here](https://docs.usercentrics.com/cmp_in_app_sdk/latest/unity/core-api/#get-cmp-data) :tada:
* [Flutter and RN] Track API is live, check out the documentation [here](https://docs.usercentrics.com/cmp_in_app_sdk/latest/api/usercentrics-core/#track) :tada:

## Improvements

* Enabled support for Hide Data Processing Services
* Added a "default" label into consent history entries, when it was given implicitly

## Resolved Issues

* Consent mediation improvements
* Solved general issues

### 2.8.1 - June 9, 2023

## Improvements

* `onConsentUpdated` event is not triggered after initialization
* Banner reshow logic

## Resolved Issues

* Boolean values sent via consent mediation to Adjust
*  Apple TV labels being cut off
*  Android TV issue when showing TCF on 2nd layer
*  Solved general issues

### 2.8.0 - May 8, 2023

## Features

* Support US Frameworks

## Improvements

* Remove deprecated method (showFirstLayer(layout: UsercetricsLayout))

## Resolved Issues

* Mediation issues
* Solved general issues

### 2.7.16

## Features

* Supporting Limited Fields in Service Descriptions.

## Improvements

* Improvements in accessibility.
* Custom UI objects are getting the latest values.

## Resolved Issues

* Solve general issues

### 2.7.15

## Resolved Issues

* Solve general issues.

* Solve issue when switches were showing the wrong value on iOS when pressing too many times repeatedly.

* Solve issue when toggles were showing on second layer even though they were disabled.

* Solve issue where the first time the app was initialized using the method getTCString, the TCString comes out empty.

* Fixed issue where DPSs accepted by default did not appear as accepted when opening second layer.

### 2.7.13

## Features

* Enabling PUR customisation properties

## Improvements

* Improvements to stability and exception handling to solve edge cases.

## Resolved Issues

* Solve issue with third party SDKs being included in POM file.
* UI improvements to CCPA Banner solution

### 2.7.12

## Improvements

* Several improvements on Consent Mediation
* Add support for Adjust and Crashlytics.
* Add support for Custom DPSs.

## Resolved Issues

* Stability improvements and bug fixes.

### 2.7.10

## Improvements

* [TCF] Performance improvement.

## Features

* Stability improvements and bug fixes.

### 2.7.9

## Features

* Add a property to disable the system back button in the first layer

### 2.7.8

## Features

* First Layer Banner has met accessibility requirements :tada:
* Remotely configure your banner layout option of your banner. This feature is only for "App Advanced" Configurations. Please contact your CSM if you would like to get access to this feature.

## Resolved Issues

* Solve CCPA issue with toggle initial value.
* Stability improvements and bug fixes

### 2.7.6

## Improvements

* Major improvements to main thread use.

## Resolved Issues

* [Android] Resolve NPE crash happening in edge cases.
* Stability improvements.

### 2.7.5

## Improvements

* Major improvements to main thread use.

## Resolved Issues

* [Android] Resolve NPE crash happening in edge cases.
* Stability improvements.

# 2.7.4

## Features

* **[A/B Testing]** With this release, you will now be able to create your own A/B Testing when showing the banner to your users. Check our [exclusive page](https://docs.usercentrics.com/cmp_in_app_sdk/latest/features/ab-testing) on how to achieve this.

## Improvements

* General bug fixes.
* [iOS] Support dynamic colors.

# 2.7.3

## Improvements

* General bug fixes.
* Huge performance improvement.

# 2.7.2

## Features

* **[Compliance]** You may now enable a close button in the First Layer, to "Continue without accepting".

## Improvements

* Improve legal link customization via our Programmatic API.
* Upgrade Error logs to help you debug the SDK's behaviour.

## Resolved Issues

* [TCF 2.0] Solve issue where shouldCollectConsent was always true.

# 2.7.1

## Features

* **[Restore User Session][TCF]** With this release, you will now be able to restore user sessions when using a TCF configuration. This feature however, needs to be enabled and approved. Please contact your Customer Success Manager for more information.

## Improvements

* API upgrades to improve performance and storage space usage.
* **[TCF]** Updates to TCF logic, for custom use cases.

## Resolved Issues

* **[iOS][Dark Mode]** Solve issue where SDK was overwritting theme to always be "light".
* Improvements to solve "NullPointerException" and unknown origin crashes.

# 2.7.0

## Features

- **[Dark Mode][Customization API]** Support Dark Mode and create advanced banner customizations with our updated [Customization API](https://docs.usercentrics.com/cmp_in_app_sdk/latest/collect_consent/usercentrics-ui/#programmatic-customization). :first_quarter_moon:
- **[Beta][Consent Mediation]** Automatically apply consent to 3rd party SDKs with our [Consent Mediation](https://docs.usercentrics.com/cmp_in_app_sdk/latest/apply_consent/consent-mediation) feature. :partying_face:
- UI improvements to history section.
- Added additional customization options for TCF 2.0 banner.

## Resolved Issues

- Solved stability issues.

# 2.6.1

## Improvements

- UI improvements to history section.
- Added additional customization options for TCF 2.0 banner.

## Resolved Issues

- Solve thread freeze issue for edge case initialization flow.
- Solved stability issues.

# 2.6.0

## Features

- **[Geolocation Rules]** By initializing our SDK using the Rule Set ID, now you can have your geolocation rules being applied for your mobile app.
- **[Custom UI]** Since we display some fields using HTML, we are now exposing them using Spanned (Android) and NSMutableAttributedString.
- **[Analytics]** To help the integration process, we've created a feature section to further explain how to use Analytics with Custom UI.

## Resolved Issues

- General bug fixes.
- Improve stability and performance issues.

# 2.5.3

## Resolved Issues

    * Fixes issues when parsing TCF String

# 2.5.2

## Resolved Issues

    * TCF String solved issue when signalling legitimate interests

# 2.5.1

## Resolved Issues

    * TCF String solved issue with encoding to shorten the length of the string

# 2.5.0

## Features

- **[UI]** Controller ID section was redesigned to have a better UX.
- `CCPAData` exposes the encoded `uspString`.

## Improvements

- Improve stability and performance issues.

## Resolved Issues

- General bug fixes.
- **[iOS]** Access to `rootViewController` depending on API version.

# 2.4.0

## Features

- **[Customization]** You now have full control over the appearance of the First & Second Layer via our Admin Interface Style options and our Programmatic API. We have updated and extended our Programmatic API to simplify banner customization.
- **[UI]** Legal links are now added to our the First Layer, and can be hidden or shown as desired via programmatic API.
- **[CCPA]** Consent button can now be customized via the Admin Interface.

## Improvements

- Improve initialization flow for stability and avoid edge case crashes.

## Resolved Issues

- Solve stability issues and bug fixes.

# 2.3.0

## Features

- **[API Update]** `shouldShowCMP` has been deprecated in favor of `shouldCollectConsent`. See [Initializing the SDK](https://docs.usercentrics.com/cmp_in_app_sdk/latest/getting_started/initialize/#initializing-the-sdk)
- **[Banner API v2]** Banner API v1 is now discontinued and removed from the SDK. If you don't wish to upgrade, please stick to v2.0.3 to avoid unexpected behaviour. See the [alert in the "Banner API V1" tab](https://docs.usercentrics.com/cmp_in_app_sdk/latest/collect_consent/present_cmp/)
- **[Banner API v2]** BannerSettings now requires a BannerFont object to pass a Bold and Regular font separately to apply for both layers. See [Banner Settings](https://docs.usercentrics.com/cmp_in_app_sdk/latest/collect_consent/customize_cmp/#banner-style-settings)
- **[Demo App]** You can now find a demo app in our documentation to test out your configuration before writing a single line of code. See [Sample Apps](https://docs.usercentrics.com/cmp_in_app_sdk/latest/samples/ios-android-demos/).

## Improvements

- Updates to TCF 2.0 framework.

## Resolved Issues

- Issue with position of logo on Second Layer is now solved.
- UI/UX improvements and fixes.

# 2.2.1

## Features

- **[Banner API v2]** A complete revamp of our banner API will enable you to have high customisation and versatility to build a end-user friendly consent banner. We can't wait for you to give it a try. For more details, see: Presenting the Banner.
  - Add a Header Image to your banner.
  - Have full control over the layour of your action buttons with Column, Row or Grid configurations.
  - Launch the second layer directly.
  - Landscape Mode support.
  - You can now add a "More Information" link to your banner message to forward users to the 2nd Layer. Appearance > Settings > More Information Link in Banner Message. Then you will be able to add this link in the banner message text editor.
- **[Usability]** Collect consent only at a category level. Option available in your Admin Interface: Configure > Legal Specifications > Settings > Category Consent.
- **[CNIL]** "Continue wthout Accepting" feature is now supported. (French regulation)
- **[Fonts]** Admin Interface fonts are now deprecated for App. To enable custom fonts, please inject the font via banner API.

## Improvements

- **[API]** Expose user's consent history.
- **[TCF 2.0]** Adding support to actively inform users when vendors are sharing data outside a region.
- **[CCPA]** Improve API to facilitate compliance with new Banner API.

## Resolved Issues
- **[TCF 2.0]** Minor design upgrades to improve usability.
- **[iOS]** Edge case with RestoreUserSession failing is now solved.
- **[iOS]** Issue with local and remote images losing quality is now solved.
- UI/UX improvements and fixes.

# 2.0.3

- Minor fix on UI related to consent toggles.
- Corner radius on iOS.

# 2.0.2

- Custom UI API.

# 2.0.1

- Initial version of the library.
