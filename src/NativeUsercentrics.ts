import { NativeModules, TurboModuleRegistry, TurboModule } from 'react-native';
import type {
  UsercentricsOptions,
  UsercentricsReadyStatus,
  BannerSettings,
  UsercentricsConsentUserResponse,
  UsercentricsServiceConsent,
  UsercentricsCMPData,
  AdditionalConsentModeData,
  TCFData,
  CCPAData,
  UserDecision,
  TCFUserDecisions,
} from './models';

export interface Spec extends TurboModule {
  // Configuration
  configure(options: UsercentricsOptions): void;
  isReady(): Promise<UsercentricsReadyStatus>;

  // UI Methods
  showFirstLayer(options?: BannerSettings): Promise<UsercentricsConsentUserResponse>;
  showSecondLayer(options?: BannerSettings): Promise<UsercentricsConsentUserResponse>;

  // Session Management
  restoreUserSession(controllerId: string): Promise<UsercentricsReadyStatus>;
  getControllerId(): Promise<string>;
  clearUserSession(): Promise<UsercentricsReadyStatus>;

  // Data Retrieval
  getConsents(): Promise<Array<UsercentricsServiceConsent>>;
  getCMPData(): Promise<UsercentricsCMPData>;
  getAdditionalConsentModeData(): Promise<AdditionalConsentModeData>;
  getTCFData(): Promise<TCFData>;
  getUserSessionData(): Promise<string>;
  getUSPData(): Promise<CCPAData>;
  getABTestingVariant(): Promise<string>;

  // Configuration Setters
  setCMPId(id: number): void;
  setABTestingVariant(variant: string): void;
  changeLanguage(language: string): Promise<void>;

  // Consent Actions
  acceptAll(consentType: number): Promise<Array<UsercentricsServiceConsent>>;
  acceptAllForTCF(fromLayer: number, consentType: number): Promise<Array<UsercentricsServiceConsent>>;
  denyAll(consentType: number): Promise<Array<UsercentricsServiceConsent>>;
  denyAllForTCF(fromLayer: number, consentType: number): Promise<Array<UsercentricsServiceConsent>>;
  
  saveDecisions(decisions: Array<UserDecision>, consentType: number): Promise<Array<UsercentricsServiceConsent>>;
  saveDecisionsForTCF(
    tcfDecisions: TCFUserDecisions,
    fromLayer: number,
    saveDecisions: Array<UserDecision>,
    consentType: number
  ): Promise<Array<UsercentricsServiceConsent>>;
  saveOptOutForCCPA(isOptedOut: boolean, consentType: number): Promise<Array<UsercentricsServiceConsent>>;

  // Analytics
  track(event: number): void;
}

// Try to get TurboModule first, fallback to NativeModule
const RNUsercentricsModule = TurboModuleRegistry.get<Spec>('RNUsercentricsModule') || NativeModules.RNUsercentricsModule;

if (!RNUsercentricsModule) {
  throw new Error(
    'Usercentrics React Native SDK: Native module not found. ' +
    'Make sure the SDK is properly installed and linked. ' +
    'For iOS, run "cd ios && pod install". ' +
    'For Android, make sure autolinking is working correctly.'
  );
}

export default RNUsercentricsModule as Spec;
