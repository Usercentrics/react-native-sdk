[Release Notes](https://docs.usercentrics.com/cmp_in_app_sdk/latest/about/history/)

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
