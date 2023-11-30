export class UsercentricsLocation {

    /// The country code. E.g 'DE'.
    countryCode: string

    /// The region code following the local format. E.g 'CA'.
    regionCode: string

    /// True, if the location is inside the European Union. False, it not.
    isInEU: boolean

    /// True, if the location is inside the United States of America. False, it not.
    isInUS: boolean

    /// True, if the location is inside the state of California. False, it not.
    isInCalifornia: boolean

    constructor(
        countryCode: string,
        regionCode: string,
        isInEU: boolean,
        isInUS: boolean,
        isInCalifornia: boolean
    ) {
        this.countryCode = countryCode
        this.regionCode = regionCode
        this.isInEU = isInEU
        this.isInUS = isInUS
        this.isInCalifornia = isInCalifornia
    }

}
