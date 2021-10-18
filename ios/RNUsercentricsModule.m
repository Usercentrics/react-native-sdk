//
//  RNUsercentricsModule.m
//  RNUsercentricsModule
//
//  Copyright © 2021 Usercentrics. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNUsercentricsModule, NSObject)
RCT_EXTERN_METHOD(configure:(NSDictionary *)dict)

RCT_EXTERN_METHOD(showCMP:(NSDictionary *)dict resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(restoreUserSession:(NSString *)controllerId resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(isReady:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(getTCFString:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(getControllerId:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(reset)
@end
