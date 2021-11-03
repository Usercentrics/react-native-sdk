import { NativeModules } from 'react-native'
import {
    UsercentricsOptions,
    UsercentricsServiceConsent,
    UsercentricsUIOptions,
    UsercentricsConsentUserResponse,
    UsercentricsReadyStatus,
    UsercentricsCMPData,
    CCPAData,
    TCFData,
    UsercentricsConsentType,
    TCFDecisionUILayer,
    UserDecision,
    TCFUserDecisions
} from './models';

const { RNUsercentricsModule } = NativeModules;

export const Usercentrics = {
    configure: (options: UsercentricsOptions) => {
        RNUsercentricsModule.configure(options)
    },

    status: (): Promise<UsercentricsReadyStatus> => {
        return RNUsercentricsModule.isReady();
    },

    showCMP: (options: UsercentricsUIOptions): Promise<UsercentricsConsentUserResponse> => {
        return RNUsercentricsModule.showCMP(options);
    },

    restoreUserSession: (controllerId: string): Promise<UsercentricsReadyStatus> => {
        return RNUsercentricsModule.restoreUserSession(controllerId);
    },

    getControllerId: (): Promise<string> => {
        return RNUsercentricsModule.getControllerId();
    },

    getTCFString: (): Promise<string> => {
        return RNUsercentricsModule.getTCFString();
    },

    getConsents: (): Promise<[UsercentricsServiceConsent]> => {
        return RNUsercentricsModule.getConsents();
    },

    getCMPData: (): Promise<UsercentricsCMPData> => {
        return RNUsercentricsModule.getCMPData();
    },

    getUserSessionData: (): Promise<string> => {
        return RNUsercentricsModule.getUserSessionData();
    },

    getCCPAData: (): Promise<CCPAData> => {
        return RNUsercentricsModule.getUSPData();
    },

    getTCFData: (): Promise<TCFData> => {
        return RNUsercentricsModule.getTCFData();
    },

    changeLanguage: (language: string): Promise<void> => {
        return RNUsercentricsModule.changeLanguage(language);
    },

    acceptAll: (consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        return RNUsercentricsModule.acceptAll(consentType);
    },

    acceptAllForTCF: (fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        return RNUsercentricsModule.acceptAllForTCF(fromLayer, consentType);
    },

    denyAll: (consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        return RNUsercentricsModule.denyAll(consentType);
    },

    denyAllForTCF: (fromLayer: TCFDecisionUILayer, consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        return RNUsercentricsModule.denyAllForTCF(fromLayer, consentType);
    },

    saveDecisions: (decisions: [UserDecision], consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        return RNUsercentricsModule.saveDecisions(decisions, consentType);
    },

    saveDecisionsForTCF: (tcfDecisions: TCFUserDecisions, fromLayer: TCFDecisionUILayer, decisions: [UserDecision], consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        return RNUsercentricsModule.saveDecisionsForTCF(tcfDecisions, fromLayer, decisions, consentType);
    },

    saveOptOutForCCPA: (isOptedOut: boolean, consentType: UsercentricsConsentType): Promise<[UsercentricsServiceConsent]> => {
        return RNUsercentricsModule.saveOptOutForCCPA(isOptedOut, consentType);
    },

    reset: () => {
        RNUsercentricsModule.reset()
    }
}
