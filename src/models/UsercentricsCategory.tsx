export class UsercentricsCategory {
    /// The category slug identifier.
    categorySlug: string

    /// The label of the category if any.
    label: string

    /// The description of the category if any.
    description: string

    /// True, if it is an essential category. False, if not.
    isEssential: boolean

    constructor(
        categorySlug: string,
        label: string,
        description: string,
        isEssential: boolean
    ) {
        this.categorySlug = categorySlug
        this.label = label
        this.description = description
        this.isEssential = isEssential
    }
}