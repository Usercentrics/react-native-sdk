import {UsercentricsCategory} from "./UsercentricsCategory";
import {UsercentricsLocation} from "./UsercentricsLocation";
import {UsercentricsService} from "./UsercentricsService";
import {UsercentricsSettings} from "./UsercentricsSettings";
import {UsercentricsVariant} from "./UsercentricsVariant";
import { LegalBasisLocalization } from "./LegalBasisLocalization";

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
    // The current legal basis localization
    legalBasis: LegalBasisLocalization

    constructor(
        settings: UsercentricsSettings,
        services: [UsercentricsService],
        categories: [UsercentricsCategory],
        activeVariant: UsercentricsVariant,
        userLocation: UsercentricsLocation,
        legalBasis: LegalBasisLocalization
    ) {
        this.settings = settings
        this.services = services
        this.categories = categories
        this.activeVariant = activeVariant
        this.userLocation = userLocation
        this.legalBasis = legalBasis
    }
}
