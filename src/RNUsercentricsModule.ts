import { TurboModuleRegistry, NativeModules } from 'react-native';
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

export interface Spec {
  configure(options: UsercentricsOptions): void;
  isReady(): Promise<UsercentricsReadyStatus>;

  showFirstLayer(options?: BannerSettings): Promise<UsercentricsConsentUserResponse>;
  showSecondLayer(options?: BannerSettings): Promise<UsercentricsConsentUserResponse>;

  restoreUserSession(controllerId: string): Promise<UsercentricsReadyStatus>;
  getControllerId(): Promise<string>;
  clearUserSession(): Promise<UsercentricsReadyStatus>;

  getConsents(): Promise<Array<UsercentricsServiceConsent>>;
  getCMPData(): Promise<UsercentricsCMPData>;
  getAdditionalConsentModeData(): Promise<AdditionalConsentModeData>;
  getTCFData(): Promise<TCFData>;
  getUserSessionData(): Promise<string>;
  getUSPData(): Promise<CCPAData>;
  getABTestingVariant(): Promise<string>;

  setCMPId(id: number): void;
  setABTestingVariant(variant: string): void;
  changeLanguage(language: string): Promise<void>;

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

  track(event: number): void;
}

// Check for TurboModule support (new architecture)
const isTurboModuleEnabled = (global as any).__turboModuleProxy != null;

// Load the native module
const NativeModule: Spec | undefined = isTurboModuleEnabled
  ? (TurboModuleRegistry.get as any)('RNUsercentricsModule')
  : NativeModules.RNUsercentricsModule;

// Safety fallback for backward compatibility
if (!NativeModule) {
  throw new Error(
    'Usercentrics React Native SDK: Native module not found.\n' +
    'iOS: run "cd ios && pod install"\n' +
    'Android: ensure autolinking is working'
  );
}

/**
 * JS Proxy wrapper to maintain both TurboModule and legacy bridge behaviors.
 * Ensures all method calls exist and throws clear errors if missing.
 */
const UsercentricsModule: Spec = new Proxy(NativeModule, {
  get(target, prop: string) {
    if (prop in target) {
      return (target as any)[prop];
    }
    // Fallback dummy implementation for backward compatibility testing
    return () => {
      throw new Error(`UsercentricsModule: Method "${prop}" is not implemented in native module`);
    };
  },
});

export default UsercentricsModule;
