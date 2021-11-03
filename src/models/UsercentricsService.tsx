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
  cookieNames: [string]
  language: string
  isLatest?: boolean
  isShared?: boolean
  shareCustomConsent: string
  linkToDpa: string
  defaultConsentStatus?: boolean
  legalGround: string
  optOutUrl: string
  policyOfProcessorUrl: string
  retentionPeriod: number
  retentionPeriodDescription: string
  iabId: string
  iabv2Id: string
  dataProtectionOfficer: string
  privacyPolicyURL: string
  cookiePolicyURL: string
  locationOfProcessing: string
  dataCollectedDescription: string
  dataPurposesDescription: string
  legalBasisDescription: string
  optOutDescription: string
  thirdCountryTransfer: string
  defaultCategoryLabel: string
  description: string
  cookieMaxAgeSeconds: number
  usesNonCookieAccess?: boolean
  deviceStorageDisclosureUrl: string
  isDeactivated?: boolean
  disableLegalBasis?: boolean


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
    cookieNames: [string],
    language: string,
    shareCustomConsent: string,
    linkToDpa: string,
    legalGround: string,
    optOutUrl: string,
    policyOfProcessorUrl: string,
    retentionPeriod: number,
    retentionPeriodDescription: string,
    iabId: string,
    iabv2Id: string,
    dataProtectionOfficer: string,
    privacyPolicyURL: string,
    cookiePolicyURL: string,
    locationOfProcessing: string,
    dataCollectedDescription: string,
    dataPurposesDescription: string,
    legalBasisDescription: string,
    optOutDescription: string,
    thirdCountryTransfer: string,
    defaultCategoryLabel: string,
    description: string,
    cookieMaxAgeSeconds: number,
    deviceStorageDisclosureUrl: string,
    isDeactivated?: boolean,
    disableLegalBasis?: boolean,
    isLatest?: boolean,
    defaultConsentStatus?: boolean,
    usesNonCookieAccess?: boolean,
    isShared?: boolean
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
    this.cookieNames = cookieNames
    this.language = language
    this.isLatest = isLatest
    this.isShared = isShared
    this.shareCustomConsent = shareCustomConsent
    this.linkToDpa = linkToDpa
    this.defaultConsentStatus = defaultConsentStatus
    this.legalGround = legalGround
    this.optOutUrl = optOutUrl
    this.policyOfProcessorUrl = policyOfProcessorUrl
    this.retentionPeriod = retentionPeriod
    this.retentionPeriodDescription = retentionPeriodDescription
    this.iabId = iabId
    this.iabv2Id = iabv2Id
    this.dataProtectionOfficer = dataProtectionOfficer
    this.privacyPolicyURL = privacyPolicyURL
    this.cookiePolicyURL = cookiePolicyURL
    this.locationOfProcessing = locationOfProcessing
    this.dataCollectedDescription = dataCollectedDescription
    this.dataPurposesDescription = dataPurposesDescription
    this.legalBasisDescription = legalBasisDescription
    this.optOutDescription = optOutDescription
    this.thirdCountryTransfer = thirdCountryTransfer
    this.defaultCategoryLabel = defaultCategoryLabel
    this.description = description
    this.cookieMaxAgeSeconds = cookieMaxAgeSeconds
    this.usesNonCookieAccess = usesNonCookieAccess
    this.deviceStorageDisclosureUrl = deviceStorageDisclosureUrl
    this.isDeactivated = isDeactivated
    this.disableLegalBasis = disableLegalBasis
    this.isEssential = isEssential
  }
}