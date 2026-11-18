/**
 * Why no age band is available. This is not a hard failure: fall back to your default behaviour.
 * **Experimental.**
 *
 * - `declined`: the person (or the parent) declined to share the age range.
 * - `notShared`: the age range is not shared with this app.
 * - `verificationRequired`: the person must verify their age in the store before a signal can be shared.
 * - `unsupported`: the OS version, the device or an optional dependency does not support the API.
 * - `notAvailable`: the platform service is not reachable here.
 * - `invalidRequest`: the platform rejected the request.
 * - `transientError`: a temporary failure. Calling again later may succeed.
 * - `timeout`: the platform did not answer in time.
 * - `error`: any other error.
 *
 * @experimental
 */
export enum UsercentricsAgeSignalUnavailableReason {

    declined = "DECLINED",
    notShared = "NOT_SHARED",
    verificationRequired = "VERIFICATION_REQUIRED",
    unsupported = "UNSUPPORTED",
    notAvailable = "NOT_AVAILABLE",
    invalidRequest = "INVALID_REQUEST",
    transientError = "TRANSIENT_ERROR",
    timeout = "TIMEOUT",
    error = "ERROR"
}
