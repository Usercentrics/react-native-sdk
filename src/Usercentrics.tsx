import {EmitterSubscription, NativeEventEmitter, NativeModules} from 'react-native';
import {
    AdditionalConsentModeData,
    BannerSettings,
    CCPAData,
    GppData,
    GppSectionChangePayload,
    SecondLayerTab,
    TCFData,
    TCFDecisionUILayer,
    TCFUserDecisionOnPurpose,
    TCFUserDecisionOnVendor,
    TCFUserDecisions,
    UsercentricsAgeSignalDecision,
    UsercentricsAnalyticsEventType,
    UsercentricsCMPData,
    UsercentricsConsentType,
    UsercentricsConsentUserResponse,
    UsercentricsOptions,
    UsercentricsPublisherAgeSignal,
    UsercentricsReadyStatus,
    UsercentricsServiceConsent,
    UserDecision,
} from './models';
import NativeUsercentrics from './NativeUsercentrics';

// Use TurboModule when available, fallback to legacy bridge
const RNUsercentricsModule = NativeUsercentrics || NativeModules.RNUsercentricsModule;
const eventEmitter = new NativeEventEmitter(RNUsercentricsModule);

export const Usercentrics = {

    configure: (options: UsercentricsOptions) => {
        RNUsercentricsModule.configure(options)
    },

    status: (): Promise<UsercentricsReadyStatus> => {
        return RNUsercentricsModule.isReady();
    },

    showFirstLayer: async (options?: BannerSettings): Promise<UsercentricsConsentUserResponse> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.showFirstLayer(options);
    },

    /**
     * Shows the second layer, optionally opened directly on [tab]: `SecondLayerTab.services` for
     * GDPR/CCPA layouts, `SecondLayerTab.partners` for TCF layouts. A tab the layout does not have,
     * or no tab, opens the default tab.
     */
    showSecondLayer: async (options?: BannerSettings, tab?: SecondLayerTab): Promise<UsercentricsConsentUserResponse> => {
        await RNUsercentricsModule.isReady();
        // The tab travels inside the options map, so the native module signatures stay unchanged.
        return RNUsercentricsModule.showSecondLayer(tab ? {...options, tab} : options);
    },

    restoreUserSession: async (controllerId: string): Promise<UsercentricsReadyStatus> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.restoreUserSession(controllerId);
    },

    getControllerId: async (): Promise<string> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.getControllerId();
    },

    getABTestingVariant: async (): Promise<string | null> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.getABTestingVariant();
    },

    getConsents: async (): Promise<Array<UsercentricsServiceConsent>> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.getConsents();
    },

    getCMPData: async (): Promise<UsercentricsCMPData> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.getCMPData();
    },

    getUserSessionData: async (): Promise<string> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.getUserSessionData();
    },

    getCCPAData: async (): Promise<CCPAData> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.getUSPData();
    },

    getGPPData: async (): Promise<GppData> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.getGPPData();
    },

    getGPPString: async (): Promise<string | null> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.getGPPString();
    },

    getTCFData: async (): Promise<TCFData> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.getTCFData();
    },

    getAdditionalConsentModeData: async (): Promise<AdditionalConsentModeData> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.getAdditionalConsentModeData();
    },

    getDpsMetadata: async (templateId: string): Promise<Record<string, unknown> | null> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.getDpsMetadata(templateId);
    },

    changeLanguage: async (language: string): Promise<void> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.changeLanguage(language);
    },

    acceptAll: async (consentType: UsercentricsConsentType): Promise<Array<UsercentricsServiceConsent>> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.acceptAll(consentType);
    },

    acceptAllForTCF: async (fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType): Promise<Array<UsercentricsServiceConsent>> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.acceptAllForTCF(fromLayer, consentType);
    },

    denyAll: async (consentType: UsercentricsConsentType): Promise<Array<UsercentricsServiceConsent>> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.denyAll(consentType);
    },

    denyAllForTCF: async (fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType, unsavedPurposeLIDecisions: TCFUserDecisionOnPurpose[] = [], unsavedVendorLIDecisions: TCFUserDecisionOnVendor[] = []): Promise<Array<UsercentricsServiceConsent>> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.denyAllForTCF(fromLayer, consentType, unsavedPurposeLIDecisions, unsavedVendorLIDecisions);
    },

    saveDecisions: async (decisions: UserDecision[], consentType: UsercentricsConsentType): Promise<Array<UsercentricsServiceConsent>> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.saveDecisions(decisions, consentType);
    },

    saveDecisionsForTCF: async (tcfDecisions: TCFUserDecisions, fromLayer: TCFDecisionUILayer, decisions: UserDecision[], consentType: UsercentricsConsentType): Promise<Array<UsercentricsServiceConsent>> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.saveDecisionsForTCF(tcfDecisions, fromLayer, decisions, consentType);
    },

    saveOptOutForCCPA: async (isOptedOut: boolean, consentType: UsercentricsConsentType): Promise<Array<UsercentricsServiceConsent>> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.saveOptOutForCCPA(isOptedOut, consentType);
    },

    setCMPId: (id: number) => {
        RNUsercentricsModule.setCMPId(id);
    },

    setABTestingVariant: (variant: string) => {
        RNUsercentricsModule.setABTestingVariant(variant);
    },

    setGPPConsent: async (sectionName: string, fieldName: string, value: unknown) => {
        await RNUsercentricsModule.isReady();
        RNUsercentricsModule.setGPPConsent(sectionName, fieldName, { value } as Object);
    },

    track: async (event: UsercentricsAnalyticsEventType) => {
        await RNUsercentricsModule.isReady();
        RNUsercentricsModule.track(event);
    },

    clearUserSession: async (): Promise<UsercentricsReadyStatus> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.clearUserSession();
    },

    onGppSectionChange: (callback: (payload: GppSectionChangePayload) => void): EmitterSubscription => {
        return eventEmitter.addListener("onGppSectionChange", callback);
    },

    // Fires when the user taps the Consent-or-Pay 1st-layer subscriber-login link. The banner is not
    // dismissed automatically — call notifyLoginSuccess once the host app confirms login, then dismiss
    // the banner yourself.
    onLoginClicked: (callback: (url: string | null) => void): EmitterSubscription => {
        return eventEmitter.addListener("onLoginClicked", callback);
    },

    // Fires when the user taps the Consent-or-Pay 1st-layer Reject & Subscribe button. The banner is not
    // dismissed automatically — call notifySubscribeSuccess once the host app confirms the subscription,
    // then dismiss the banner yourself.
    onSubscribeClicked: (callback: (url: string | null) => void): EmitterSubscription => {
        return eventEmitter.addListener("onSubscribeClicked", callback);
    },

    // Clears stored TCF consent data after a successful Consent-or-Pay login.
    notifyLoginSuccess: async (): Promise<void> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.notifyLoginSuccess();
    },

    // Clears stored TCF consent data after a successful Consent-or-Pay subscription.
    notifySubscribeSuccess: async (): Promise<void> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.notifySubscribeSuccess();
    },

    // Notifies the SDK that a previously active Consent-or-Pay subscription has lapsed,
    // resetting the subscriber flag so the host app can re-surface the banner. Does not
    // alter any existing consent data, which remains accurate.
    notifySubscriptionLapsed: async (): Promise<void> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.notifySubscriptionLapsed();
    },

    /**
     * **Experimental**: it may change or be removed without a major version bump.
     *
     * Hands the SDK an age range the app already knows about its user, for example a "16+" flag from the
     * app's own age gate. Build the [signal] with `UsercentricsPublisherAgeSignal.atLeast`, `below` or `between`.
     *
     * The SDK checks the range, tags it as provided by the app (`UsercentricsAgeSignalTrust.publisherProvided`,
     * which the app cannot change, so it is never mistaken for an age that a platform verified) and resolves the
     * band with the same rules as the Apple and Google signals. The promise resolves with the decision, or rejects
     * with a fixed message that does not repeat what was passed: for a range that is not valid (an age outside 0..120,
     * a lower age above the upper one, a label that is not 1 to 32 characters of A-Z a-z 0-9 . _ -) and for a signal
     * the bridge cannot read (an age that is missing or is not a whole number: a fraction, NaN, a boolean). A rejection
     * carries the code `usercentrics_reactNative_setAgeSignal_error` on Android and on iOS, so an app can match on it.
     *
     * The signal counts from now on and the last call wins. Nothing is stored or sent, and consent does not
     * change. Send it again after each start. The signal and the decision carry the age: do not log them.
     *
     * @experimental
     */
    setAgeSignal: async (signal: UsercentricsPublisherAgeSignal): Promise<UsercentricsAgeSignalDecision> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.setAgeSignal(signal);
    },
}
