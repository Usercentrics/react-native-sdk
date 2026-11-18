/**
 * How trustworthy the age behind a signal is. **Experimental.**
 *
 * - `selfDeclared`: the person declared their own age.
 * - `guardianDeclared`: a parent or guardian set the age.
 * - `verified`: the age was checked by the platform (a government ID, a payment method or another method).
 * - `publisherProvided`: the host app declared the age itself, through `Usercentrics.setAgeSignal`. It is never
 *   `verified`: neither the SDK nor a platform checked it, so it is only as good as the host's own age gate.
 *
 * @experimental
 */
export enum UsercentricsAgeSignalTrust {

    selfDeclared = "SELF_DECLARED",
    guardianDeclared = "GUARDIAN_DECLARED",
    verified = "VERIFIED",
    publisherProvided = "PUBLISHER_PROVIDED"
}
