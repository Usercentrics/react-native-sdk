import {ConsentDisclosureObject} from "./ConsentDisclosureObject";

export class UsercentricsService {

    /// The template ID of the service.
    templateId: string

    /// The version of the service.
    version: string

    /// The category slug identifier of the service.
    categorySlug: string

    isEssential: boolean

    type: string
    dataProcessor: string
    dataPurposes: [string]
    processingCompany: string
    nameOfProcessingCompany: string
    addressOfProcessingCompany: string
    descriptionOfService: string
    languagesAvailable: [string]
    dataCollectedList: [string]
    dataPurposesList: [string]
    dataRecipientsList: [string]
    legalBasisList: [string]
    retentionPeriodList: [string]
    subConsents: [string]
    language: string
    linkToDpa: string
    legalGround: string
    optOutUrl: string
    policyOfProcessorUrl: string
    retentionPeriodDescription: string
    dataProtectionOfficer: string
    privacyPolicyURL: string
    cookiePolicyURL: string
    locationOfProcessing: string
    dataCollectedDescription: string
    thirdCountryTransfer: string
    description: string
    cookieMaxAgeSeconds: number
    usesNonCookieAccess?: boolean
    deviceStorageDisclosureUrl: string
    technologyUsed: [string]
    isDeactivated?: boolean
    disableLegalBasis?: boolean
    deviceStorage?: ConsentDisclosureObject
    isHidden: boolean

    constructor(
        templateId: string,
        version: string,
        categorySlug: string,
        type: string,
        isEssential: boolean,
        dataProcessor: string,
        dataPurposes: [string],
        processingCompany: string,
        nameOfProcessingCompany: string,
        addressOfProcessingCompany: string,
        descriptionOfService: string,
        languagesAvailable: [string],
        dataCollectedList: [string],
        dataPurposesList: [string],
        dataRecipientsList: [string],
        legalBasisList: [string],
        retentionPeriodList: [string],
        subConsents: [string],
        language: string,
        linkToDpa: string,
        legalGround: string,
        optOutUrl: string,
        policyOfProcessorUrl: string,
        retentionPeriod: number,
        retentionPeriodDescription: string,
        dataProtectionOfficer: string,
        privacyPolicyURL: string,
        cookiePolicyURL: string,
        locationOfProcessing: string,
        dataCollectedDescription: string,
        thirdCountryTransfer: string,
        description: string,
        cookieMaxAgeSeconds: number,
        deviceStorageDisclosureUrl: string,
        technologyUsed: [string],
        isHidden: boolean,
        isDeactivated?: boolean,
        disableLegalBasis?: boolean,
        usesNonCookieAccess?: boolean,
        deviceStorage?: ConsentDisclosureObject,
    ) {
        this.templateId = templateId
        this.version = version
        this.categorySlug = categorySlug
        this.type = type
        this.dataProcessor = dataProcessor
        this.dataPurposes = dataPurposes
        this.processingCompany = processingCompany
        this.nameOfProcessingCompany = nameOfProcessingCompany
        this.addressOfProcessingCompany = addressOfProcessingCompany
        this.descriptionOfService = descriptionOfService
        this.languagesAvailable = languagesAvailable
        this.dataCollectedList = dataCollectedList
        this.dataPurposesList = dataPurposesList
        this.dataRecipientsList = dataRecipientsList
        this.legalBasisList = legalBasisList
        this.retentionPeriodList = retentionPeriodList
        this.subConsents = subConsents
        this.language = language
        this.linkToDpa = linkToDpa
        this.legalGround = legalGround
        this.optOutUrl = optOutUrl
        this.policyOfProcessorUrl = policyOfProcessorUrl
        this.retentionPeriodDescription = retentionPeriodDescription
        this.dataProtectionOfficer = dataProtectionOfficer
        this.privacyPolicyURL = privacyPolicyURL
        this.cookiePolicyURL = cookiePolicyURL
        this.locationOfProcessing = locationOfProcessing
        this.dataCollectedDescription = dataCollectedDescription
        this.thirdCountryTransfer = thirdCountryTransfer
        this.description = description
        this.cookieMaxAgeSeconds = cookieMaxAgeSeconds
        this.usesNonCookieAccess = usesNonCookieAccess
        this.deviceStorageDisclosureUrl = deviceStorageDisclosureUrl
        this.isDeactivated = isDeactivated
        this.disableLegalBasis = disableLegalBasis
        this.isEssential = isEssential
        this.technologyUsed = technologyUsed
        this.deviceStorage = deviceStorage
        this.isHidden = isHidden
    }
}
