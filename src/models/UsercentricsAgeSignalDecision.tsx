import {
    UsercentricsAgeBand,
    UsercentricsAgeSignalSource,
    UsercentricsAgeSignalTrust,
    UsercentricsAgeSignalUnavailableReason
} from "."

/**
 * The outcome of an age signal request, as data. **Experimental.**
 *
 * - `source`: where the signal comes from.
 * - `trust`: how the age was established, or `null` when `band` is `null`.
 * - `band`: the resolved band, or `null` when no signal is available (see `unavailableReason`). `null` is never an
 *   adult: it means "no signal", and what the app does without one is its own decision. Test
 *   `band === UsercentricsAgeBand.standard` for an adult.
 * - `ageLower`: inclusive lower bound of the age range, or `null` when it is not known.
 * - `ageUpper`: inclusive upper bound, or `null` for an open-ended range (for example 18+).
 * - `unavailableReason`: why there is no band, or `null` when there is one.
 * - `isAvailable`: `true` when a `band` was resolved. `false` is "no signal", not "adult".
 *
 * The age range is sensitive: do not log it, report it or send it to analytics, and read `ageLower` and `ageUpper`
 * only where the range is needed. Platform signals (Google Play Age Signals) may only be used to provide
 * age-appropriate content and experiences in compliance with law, never for advertising, marketing, user
 * profiling or analytics, and must not be shared with ad or analytics SDKs.
 *
 * @experimental
 */
export class UsercentricsAgeSignalDecision {

    source: UsercentricsAgeSignalSource
    trust: UsercentricsAgeSignalTrust | null
    band: UsercentricsAgeBand | null
    ageLower: number | null
    ageUpper: number | null
    unavailableReason: UsercentricsAgeSignalUnavailableReason | null
    isAvailable: boolean

    constructor(source: UsercentricsAgeSignalSource,
                trust: UsercentricsAgeSignalTrust | null,
                band: UsercentricsAgeBand | null,
                ageLower: number | null,
                ageUpper: number | null,
                unavailableReason: UsercentricsAgeSignalUnavailableReason | null) {
        this.source = source
        this.trust = trust
        this.band = band
        this.ageLower = ageLower
        this.ageUpper = ageUpper
        this.unavailableReason = unavailableReason
        this.isAvailable = band !== null
    }
}
