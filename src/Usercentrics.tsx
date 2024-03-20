import {NativeModules} from 'react-native';
import {
    AdditionalConsentModeData,
    BannerSettings,
    CCPAData,
    TCFData,
    TCFDecisionUILayer,
    TCFUserDecisions,
    UsercentricsAnalyticsEventType,
    UsercentricsCMPData,
    UsercentricsConsentType,
    UsercentricsConsentUserResponse,
    UsercentricsOptions,
    UsercentricsReadyStatus,
    UsercentricsServiceConsent,
    UserDecision,
} from './models';

const {RNUsercentricsModule} = NativeModules;

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

    showSecondLayer: async (options?: BannerSettings): Promise<UsercentricsConsentUserResponse> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.showSecondLayer(options);
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

    getConsents: async (): Promise<[UsercentricsServiceConsent]> => {
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

    getTCFData: async (): Promise<TCFData> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.getTCFData();
    },

    getAdditionalConsentModeData: async (): Promise<AdditionalConsentModeData> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.getAdditionalConsentModeData();
    },

    changeLanguage: async (language: string): Promise<void> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.changeLanguage(language);
    },

    acceptAll: async (consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.acceptAll(consentType);
    },

    acceptAllForTCF: async (fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.acceptAllForTCF(fromLayer, consentType);
    },

    denyAll: async (consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.denyAll(consentType);
    },

    denyAllForTCF: async (fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.denyAllForTCF(fromLayer, consentType);
    },

    saveDecisions: async (decisions: UserDecision[], consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.saveDecisions(decisions, consentType);
    },

    saveDecisionsForTCF: async (tcfDecisions: TCFUserDecisions, fromLayer: TCFDecisionUILayer, decisions: UserDecision[], consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.saveDecisionsForTCF(tcfDecisions, fromLayer, decisions, consentType);
    },

    saveOptOutForCCPA: async (isOptedOut: boolean, consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.saveOptOutForCCPA(isOptedOut, consentType);
    },

    setCMPId: (id: number) => {
        RNUsercentricsModule.setCMPId(id);
    },

    setABTestingVariant: (variant: string) => {
        RNUsercentricsModule.setABTestingVariant(variant);
    },

    track: async (event: UsercentricsAnalyticsEventType) => {
        await RNUsercentricsModule.isReady();
        RNUsercentricsModule.track(event);
    },

    /**
     * @deprecated This method will be removed in the next version. Please consider using the clearUserSession() method instead
     */
    reset: () => {
        RNUsercentricsModule.reset()
    },

    clearUserSession: async (): Promise<UsercentricsReadyStatus> => {
        await RNUsercentricsModule.isReady();
        return RNUsercentricsModule.clearUserSession();
    },
}
