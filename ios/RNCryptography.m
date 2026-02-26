#import <React/RCTBridge.h>

@interface RCT_EXTERN_MODULE(RNCryptography, NSObject)


+(BOOL)requiresMainQueueSetup {
  return YES;
}



RCT_EXTERN_METHOD(encryptAesCcm:(NSArray *)plaintext
                  key:(NSArray *)key
                  iv:(NSArray *)iv
                  tagLength:(NSInteger)tagLength
                  aad:(NSArray *)aad
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(decryptAesCcm:(NSArray *)ciphertext
                  key:(NSArray *)key
                  iv:(NSArray *)iv
                  authTag:(NSArray *)authTag
                  tagLength:(NSInteger)tagLength
                  aad:(NSArray *)aad
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(encryptAesGcm:(NSArray *)plaintext
                  key:(NSArray *)key
                  iv:(NSArray *)iv
                  tagLength:(NSInteger)tagLength
                  aad:(NSArray *)aad
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(decryptAesGcm:(NSArray *)ciphertext
                  key:(NSArray *)key
                  iv:(NSArray *)iv
                  authTag:(NSArray *)authTag
                  tagLength:(NSInteger)tagLength
                  aad:(NSArray *)aad
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)


RCT_EXTERN_METHOD(encryptAES:(NSString *)message
                  key:(NSString *)key
                  iv:(NSString *)iv
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)


RCT_EXTERN_METHOD(decryptAES:(NSString *)message
                  key:(NSString *)key
                  iv:(NSString *)iv
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)


RCT_EXTERN_METHOD(md5:(NSString *)value
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)


RCT_EXTERN_METHOD(sha256:(NSString *)value
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
