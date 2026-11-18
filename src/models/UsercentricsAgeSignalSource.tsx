/**
 * Where an age signal comes from. **Experimental.**
 *
 * - `appleDeclaredAgeRange`: the Apple `DeclaredAgeRange` framework (iOS 26+).
 * - `googlePlayAgeSignals`: the Google Play Age Signals API (Android 6.0+, builds distributed by Google Play).
 * - `publisherProvided`: the host app provided the age itself, through `Usercentrics.setAgeSignal`. No platform
 *   vouches for it and the SDK cannot check it.
 *
 * @experimental
 */
export enum UsercentricsAgeSignalSource {

    appleDeclaredAgeRange = "APPLE_DECLARED_AGE_RANGE",
    googlePlayAgeSignals = "GOOGLE_PLAY_AGE_SIGNALS",
    publisherProvided = "PUBLISHER_PROVIDED"
}
