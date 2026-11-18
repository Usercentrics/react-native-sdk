/**
 * An age range the host app (the publisher) already knows about its user, to hand to `Usercentrics.setAgeSignal`.
 * **Experimental.**
 *
 * Build it with `atLeast`, `below` or `between`. The factories never throw: the native SDK checks the range when it
 * is handed over, and one that is not valid rejects the promise of `setAgeSignal`.
 *
 * The optional `sourceLabel` names where the app got the age from (for example `my-age-gate`). It is written to the
 * SDK logger and handed to the age signal engine, and goes nowhere else. It must be 1 to 32 characters of `A-Z`,
 * `a-z`, `0-9`, `.`, `_` or `-`: no personal data.
 *
 * The band follows the lower age, and a signal without one counts it as 0: `atLeast` and `between` resolve to the
 * band of their lower age, and `below` always resolves to the lowest band, because it gives an upper age only.
 *
 * A signal carries no trust level. The SDK always tags it `UsercentricsAgeSignalTrust.publisherProvided`, so an app
 * cannot present its own flag as one that a platform verified.
 *
 * @experimental
 */
export class UsercentricsPublisherAgeSignal {

    readonly kind: "atLeast" | "below" | "between"
    readonly age?: number
    readonly lower?: number
    readonly upper?: number
    readonly sourceLabel?: string

    private constructor(fields: Pick<UsercentricsPublisherAgeSignal, "kind" | "age" | "lower" | "upper" | "sourceLabel">) {
        this.kind = fields.kind
        // Only the fields that were given exist, so nothing else travels to the native layer
        if (fields.age !== undefined) this.age = fields.age
        if (fields.lower !== undefined) this.lower = fields.lower
        if (fields.upper !== undefined) this.upper = fields.upper
        if (fields.sourceLabel !== undefined) this.sourceLabel = fields.sourceLabel
    }

    /** The person is `age` or older, for example `atLeast(16)` for a "16+" flag. No upper age is known. */
    static atLeast(age: number, sourceLabel?: string): UsercentricsPublisherAgeSignal {
        return new UsercentricsPublisherAgeSignal({kind: "atLeast", age, sourceLabel})
    }

    /** The person is younger than `age`, for example `below(16)` for an "under 16" flag. No lower age is known. */
    static below(age: number, sourceLabel?: string): UsercentricsPublisherAgeSignal {
        return new UsercentricsPublisherAgeSignal({kind: "below", age, sourceLabel})
    }

    /** The person is between `lower` and `upper` years old, both included, for example `between(13, 15)`. */
    static between(lower: number, upper: number, sourceLabel?: string): UsercentricsPublisherAgeSignal {
        return new UsercentricsPublisherAgeSignal({kind: "between", lower, upper, sourceLabel})
    }
}
