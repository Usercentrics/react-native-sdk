import {BannerInitCustomization, NetworkMode, UsercentricsLoggerLevel} from ".";

export class UsercentricsOptions {
    settingsId?: string;
    ruleSetId?: string;
    defaultLanguage?: string;
    loggerLevel?: UsercentricsLoggerLevel;
    timeoutMillis?: number;
    version?: string;
    networkMode?: NetworkMode;
    consentMediation?: Boolean;
    initTimeoutMillis?: number;
    /**
     * Optional controllerId to inject at SDK initialisation.
     *
     * Use this to preserve user identity across login/logout flows that clear local consent
     * storage. Store the controllerId (via `Usercentrics.getControllerId()`) server-side after
     * the first successful init, then pass it here on every subsequent login. The SDK will skip
     * generating a new ID and use this value instead. It is persisted to local storage, so
     * subsequent re-initialisations without this option continue to use it.
     *
     * The value must be a 64-character lowercase hexadecimal string (the format produced
     * internally by the SDK). Invalid values are ignored with a warning log and the SDK falls
     * back to its normal ID resolution (stored → generated).
     */
    controllerId?: string;
    /**
     * @deprecated bannerCustomization is deprecated and will be removed in a future release.
     * Configure banner appearance via the Usercentrics dashboard instead.
     */
    bannerCustomization?: BannerInitCustomization;

    constructor({
                    settingsId = "",
                    ruleSetId = "",
                    defaultLanguage = undefined,
                    loggerLevel = undefined,
                    timeoutMillis = undefined,
                    version = undefined,
                    networkMode = undefined,
                    consentMediation = undefined,
                    initTimeoutMillis = undefined,
                    controllerId = undefined,
                    bannerCustomization = undefined
                }: {
        settingsId?: string,
        ruleSetId?: string,
        defaultLanguage?: string,
        loggerLevel?: UsercentricsLoggerLevel,
        timeoutMillis?: number,
        version?: string,
        networkMode?: NetworkMode,
        consentMediation?: Boolean,
        initTimeoutMillis?: number,
        controllerId?: string,
        bannerCustomization?: BannerInitCustomization
    }) {
        this.settingsId = settingsId;
        this.ruleSetId = ruleSetId;
        this.defaultLanguage = defaultLanguage
        this.loggerLevel = loggerLevel
        this.timeoutMillis = timeoutMillis
        this.version = version
        this.networkMode = networkMode
        this.consentMediation = consentMediation
        this.initTimeoutMillis = initTimeoutMillis
        this.controllerId = controllerId
        this.bannerCustomization = bannerCustomization
    }
}
