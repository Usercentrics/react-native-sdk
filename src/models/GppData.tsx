export class GppData {
    gppString: string
    applicableSections: number[]
    sections: Record<string, Record<string, unknown>>

    constructor(
        gppString: string,
        applicableSections: number[],
        sections: Record<string, Record<string, unknown>>
    ) {
        this.gppString = gppString
        this.applicableSections = applicableSections
        this.sections = sections
    }
}
