import { UsercentricsCategory } from "./UsercentricsCategory";
import { UsercentricsLocation } from "./UsercentricsLocation";
import { UsercentricsService } from "./UsercentricsService";
import { UsercentricsSettings } from "./UsercentricsSettings";
import { UsercentricsVariant } from "./UsercentricsVariant";

export class UsercentricsCMPData {
    /// The general settings defined for the settingsId.
    settings: UsercentricsSettings
    /// The services defined for the settingsId.
    services: [UsercentricsService]
    /// The categories defined for the settingsId.
    categories: [UsercentricsCategory]
    /// The active variant.
    activeVariant: UsercentricsVariant
    /// The current user location.
    userLocation: UsercentricsLocation

    constructor(
        settings: UsercentricsSettings,
        services: [UsercentricsService],
        categories: [UsercentricsCategory],
        activeVariant: UsercentricsVariant,
        userLocation: UsercentricsLocation
    ) {
        this.settings = settings
        this.services = services
        this.categories = categories
        this.activeVariant = activeVariant
        this.userLocation = userLocation
    }
}