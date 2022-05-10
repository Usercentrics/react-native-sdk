import { NetworkMode, UsercentricsLoggerLevel } from ".";

export class UsercentricsOptions {
    settingsId: string;
    defaultLanguage?: string;
    loggerLevel?: UsercentricsLoggerLevel;
    timeoutMillis?: number;
    version?: string;
    networkMode?: NetworkMode;

    constructor(settingsId: string,
        defaultLanguage?: string,
        loggerLevel?: UsercentricsLoggerLevel,
        timeoutMillis?: number,
        version?: string,
        networkMode?: NetworkMode) {
        this.settingsId = settingsId;
        this.defaultLanguage = defaultLanguage
        this.loggerLevel = loggerLevel
        this.timeoutMillis = timeoutMillis
        this.version = version
        this.networkMode = networkMode
    }
}