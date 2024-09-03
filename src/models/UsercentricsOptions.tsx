import {NetworkMode, UsercentricsLoggerLevel} from ".";

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

    constructor({
                    settingsId = "",
                    ruleSetId = "",
                    defaultLanguage = undefined,
                    loggerLevel = undefined,
                    timeoutMillis = undefined,
                    version = undefined,
                    networkMode = undefined,
                    consentMediation = undefined,
                    initTimeoutMillis = undefined
                }: {
        settingsId?: string,
        ruleSetId?: string,
        defaultLanguage?: string,
        loggerLevel?: UsercentricsLoggerLevel,
        timeoutMillis?: number,
        version?: string,
        networkMode?: NetworkMode,
        consentMediation?: Boolean,
        initTimeoutMillis?: number
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
    }
}
