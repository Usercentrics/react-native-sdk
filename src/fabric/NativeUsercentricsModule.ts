import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  // Configuration
  configure(options: Object): void;
  isReady(): Promise<Object>;

  // UI Methods
  showFirstLayer(options?: Object): Promise<Object>;
  showSecondLayer(options?: Object): Promise<Object>;

  // Session Management
  restoreUserSession(controllerId: string): Promise<Object>;
  getControllerId(): Promise<string>;
  clearUserSession(): Promise<Object>;

  // Data Retrieval
  getConsents(): Promise<Array<Object>>;
  getCMPData(): Promise<Object>;
  getAdditionalConsentModeData(): Promise<Object>;
  getTCFData(): Promise<Object>;
  getUserSessionData(): Promise<string>;
  getUSPData(): Promise<Object>;
  getABTestingVariant(): Promise<string>;

  // Configuration Setters
  setCMPId(id: number): void;
  setABTestingVariant(variant: string): void;
  changeLanguage(language: string): Promise<void>;

  // Consent Actions
  acceptAll(consentType: number): Promise<Array<Object>>;
  acceptAllForTCF(fromLayer: number, consentType: number): Promise<Array<Object>>;
  denyAll(consentType: number): Promise<Array<Object>>;
  denyAllForTCF(fromLayer: number, consentType: number, unsavedPurposeLIDecisions: Array<Object>): Promise<Array<Object>>;
  
  saveDecisions(decisions: Array<Object>, consentType: number): Promise<Array<Object>>;
  saveDecisionsForTCF(
    tcfDecisions: Object,
    fromLayer: number,
    saveDecisions: Array<Object>,
    consentType: number
  ): Promise<Array<Object>>;
  saveOptOutForCCPA(isOptedOut: boolean, consentType: number): Promise<Array<Object>>;

  // Analytics
  track(event: number): void;
}

export default TurboModuleRegistry.get<Spec>('RNUsercentricsModule');
