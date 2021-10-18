import { UsercentricsLoggerLevel } from ".";

export class UsercentricsOptions {
    settingsId: string;
    defaultLanguage?: string;
    loggerLevel?: UsercentricsLoggerLevel;
    timeoutMillis?: number;
    version?: string;

    constructor(settingsId: string,
        defaultLanguage?: string,
        loggerLevel?: UsercentricsLoggerLevel,
        timeoutMillis?: number,
        version?: string) {
        this.settingsId = settingsId;
        this.defaultLanguage = defaultLanguage
        this.loggerLevel = loggerLevel
        this.timeoutMillis = timeoutMillis
        this.version = version
    }
}