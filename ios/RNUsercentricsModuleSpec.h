#import <React/RCTBridgeModule.h>
#import <React/RCTTurboModule.h>
#import <ReactCommon/RCTTurboModule.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NativeUsercentricsSpec <RCTBridgeModule, RCTTurboModule>

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
- (void)setCMPId:(NSInteger)cmpId;
- (void)setABTestingVariant:(NSString *)variant;
- (void)changeLanguage:(NSString *)language
               resolve:(RCTPromiseResolveBlock)resolve
                reject:(RCTPromiseRejectBlock)reject;

// Consent Actions
- (void)acceptAll:(NSInteger)consentType
          resolve:(RCTPromiseResolveBlock)resolve
           reject:(RCTPromiseRejectBlock)reject;

- (void)acceptAllForTCF:(NSInteger)fromLayer
            consentType:(NSInteger)consentType
                resolve:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject;

- (void)denyAll:(NSInteger)consentType
        resolve:(RCTPromiseResolveBlock)resolve
         reject:(RCTPromiseRejectBlock)reject;

- (void)denyAllForTCF:(NSInteger)fromLayer
          consentType:(NSInteger)consentType
              resolve:(RCTPromiseResolveBlock)resolve
               reject:(RCTPromiseRejectBlock)reject;

- (void)saveDecisions:(NSArray<NSDictionary *> *)decisions
          consentType:(NSInteger)consentType
              resolve:(RCTPromiseResolveBlock)resolve
               reject:(RCTPromiseRejectBlock)reject;

- (void)saveDecisionsForTCF:(NSDictionary *)tcfDecisions
                  fromLayer:(NSInteger)fromLayer
              saveDecisions:(NSArray<NSDictionary *> *)saveDecisions
                consentType:(NSInteger)consentType
                    resolve:(RCTPromiseResolveBlock)resolve
                     reject:(RCTPromiseRejectBlock)reject;

- (void)saveOptOutForCCPA:(BOOL)isOptedOut
              consentType:(NSInteger)consentType
                  resolve:(RCTPromiseResolveBlock)resolve
                   reject:(RCTPromiseRejectBlock)reject;

// Analytics
- (void)track:(NSInteger)event;

@end

NS_ASSUME_NONNULL_END

