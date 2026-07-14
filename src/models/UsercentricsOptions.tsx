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
        this.bannerCustomization = bannerCustomization
    }
}
