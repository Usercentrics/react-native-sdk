export class CCPAData {
    /// CCPA version.
    version: number

    /// True if the user opted out the consents, so the user denies the services. False if not, so the user accepts the services.
    optedOut?: boolean

    /// Limited Service Provider Agreement Covered Transaction.
    lspact?: boolean

    /// True if the notice was given. False if not.
    noticeGiven?: boolean


    constructor(
        version: number,
        optedOut?: boolean,
        lspact?: boolean,
        noticeGiven?: boolean
    ) {
        this.version = version
        this.optedOut = optedOut
        this.lspact = lspact
        this.noticeGiven = noticeGiven
    }
}