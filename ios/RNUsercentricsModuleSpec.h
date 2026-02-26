#import <React/RCTBridgeModule.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NativeUsercentricsSpec <RCTBridgeModule>

// Configuration
- (void)configure:(NSDictionary *)options;
- (void)isReady:(RCTPromiseResolveBlock)resolve
         reject:(RCTPromiseRejectBlock)reject;

// UI Methods
- (void)showFirstLayer:(nullable NSDictionary *)options
               resolve:(RCTPromiseResolveBlock)resolve
                reject:(RCTPromiseRejectBlock)reject;

- (void)showSecondLayer:(nullable NSDictionary *)options
                resolve:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject;

// Session Management
- (void)restoreUserSession:(NSString *)controllerId
                   resolve:(RCTPromiseResolveBlock)resolve
                    reject:(RCTPromiseRejectBlock)reject;

- (void)getControllerId:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject;

- (void)clearUserSession:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject;

// Data Retrieval
- (void)getConsents:(RCTPromiseResolveBlock)resolve
             reject:(RCTPromiseRejectBlock)reject;

- (void)getCMPData:(RCTPromiseResolveBlock)resolve
            reject:(RCTPromiseRejectBlock)reject;

- (void)getAdditionalConsentModeData:(RCTPromiseResolveBlock)resolve
                              reject:(RCTPromiseRejectBlock)reject;

- (void)getTCFData:(RCTPromiseResolveBlock)resolve
            reject:(RCTPromiseRejectBlock)reject;

- (void)getUserSessionData:(RCTPromiseResolveBlock)resolve
                    reject:(RCTPromiseRejectBlock)reject;

- (void)getUSPData:(RCTPromiseResolveBlock)resolve
            reject:(RCTPromiseRejectBlock)reject;

- (void)getABTestingVariant:(RCTPromiseResolveBlock)resolve
                     reject:(RCTPromiseRejectBlock)reject;

// Configuration Setters
- (void)setCMPId:(double)cmpId;
- (void)setABTestingVariant:(NSString *)variant;
- (void)changeLanguage:(NSString *)language
               resolve:(RCTPromiseResolveBlock)resolve
                reject:(RCTPromiseRejectBlock)reject;

// Consent Actions
- (void)acceptAll:(double)consentType
          resolve:(RCTPromiseResolveBlock)resolve
           reject:(RCTPromiseRejectBlock)reject;

- (void)acceptAllForTCF:(double)fromLayer
            consentType:(double)consentType
                resolve:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject;

- (void)denyAll:(double)consentType
        resolve:(RCTPromiseResolveBlock)resolve
         reject:(RCTPromiseRejectBlock)reject;

- (void)denyAllForTCF:(double)fromLayer
          consentType:(double)consentType
          unsavedPurposeLIDecisions:(NSArray<NSDictionary *> *)unsavedPurposeLIDecisions
              resolve:(RCTPromiseResolveBlock)resolve
               reject:(RCTPromiseRejectBlock)reject;

- (void)saveDecisions:(NSArray<NSDictionary *> *)decisions
          consentType:(double)consentType
              resolve:(RCTPromiseResolveBlock)resolve
               reject:(RCTPromiseRejectBlock)reject;

- (void)saveDecisionsForTCF:(NSDictionary *)tcfDecisions
                  fromLayer:(double)fromLayer
              saveDecisions:(NSArray<NSDictionary *> *)saveDecisions
                consentType:(double)consentType
                    resolve:(RCTPromiseResolveBlock)resolve
                     reject:(RCTPromiseRejectBlock)reject;

- (void)saveOptOutForCCPA:(BOOL)isOptedOut
              consentType:(double)consentType
                  resolve:(RCTPromiseResolveBlock)resolve
                   reject:(RCTPromiseRejectBlock)reject;

// Analytics
- (void)track:(double)event;

@end

NS_ASSUME_NONNULL_END

