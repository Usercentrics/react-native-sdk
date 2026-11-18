/**
 * The age band an age signal resolves to. **Experimental.**
 *
 * - `belowMinimum`: below the minimum age.
 * - `minor`: at or above the minimum age, but not (provably) an adult.
 * - `standard`: an adult.
 *
 * A decision without a band means "no signal", never "adult": test `band === UsercentricsAgeBand.standard`
 * for an adult, because `band !== UsercentricsAgeBand.minor` would take both a missing signal and a child
 * below the minimum age for one.
 *
 * @experimental
 */
export enum UsercentricsAgeBand {

    belowMinimum = "BELOW_MINIMUM",
    minor = "MINOR",
    standard = "STANDARD"
}
